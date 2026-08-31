# Managing External USB Drives on the PrimeStation One

The PrimeStation One serves files and Plex media from USB drives plugged into the Pi. This document explains **how USB drives get mounted**, and — most importantly — **how to connect a brand-new drive without rebooting the system**.

---

## 1. The short answer (TL;DR)

To mount a newly plugged-in drive **right now, without rebooting**, run this as root:

```bash
sudo mountusbbylabel.sh
```

This mounts *every* connected drive (including the one you just plugged in) under a folder in `/media/` named after its **volume label**. For example, a drive labeled `PLEX` becomes available at **`/media/PLEX`**.

If the `mountusbbylabel.sh` command is not on your `PATH` (see [§5 Where does all this live?](#5-where-does-all-this-live)), call it directly:

```bash
sudo ~/debianusbfileserver/scripts/mountusbbylabel.sh
```

---

## 2. How USB drives are normally mounted

There are **two cooperating mechanisms**. Understanding both is the key to never being confused about where a drive "lives."

### 2.1 The `usbmount` service (automatic, hotplug)

`usbmount` is a Debian package that auto-mounts removable drives the moment they are plugged in. RetroPie installs it as part of `usbromservice`, and it mounts drives into numbered folders:

```
/media/usb0
/media/usb1
/media/usb2
...up to /media/usb7
```

Its behavior is controlled by a single config file:

```
/etc/usbmount/usbmount.conf
```

The most important line is:

```bash
ENABLED=1    # 1 = on, 0 = off
```

> There are reference copies of this config in the repo under
> `reference/etc/usbmount/` (`usbmount.fromPrimestation093alpha.conf` and `usbmount.fromRetroPie24beta.conf`).

### 2.2 The by-label mechanism (self-explanatory mount points)

`/media/usb0`, `/media/usb1`, ... are **not** very descriptive. To fix that, the PrimeStation mounts drives by their **volume label**, so the mount path tells you exactly what the drive is:

```
/media/<volume-label>
```

Two complementary things make this happen:

- **`mountusbbylabel.sh`** — an explicit "walk all drives and mount by label" script (see §3).
- **`02_create_label_symlink`** — a `usbmount` *hook* (`mount.d/`) that, whenever `usbmount` mounts a drive to `/media/usbN`, also creates a symlink `/media/<label>` → `/media/usbN`. The matching `umount.d/01_remove_label_symlink` hook removes it on unplug.

So after a normal boot you typically end up with **both** a numbered mount point **and** a human-friendly label symlink (or a second, real mount) pointing at the same drive.

---

## 3. Mounting drives by label

### 3.1 The script you were looking for

Your memory of *"a script that auto-enables the feature, walks all USB drives, mounts them by volume name, then disables the feature again"* matches these companion-repo scripts exactly:

| Script | What it does |
| --- | --- |
| `mountusbbylabel.sh` | Mounts **all** connected drives under `/media/<label>`. |
| `enableusbmountservice.sh` | Sets `ENABLED=1` in `/etc/usbmount/usbmount.conf`. |
| `disableusbmountservice.sh` | Sets `ENABLED=0` in `/etc/usbmount/usbmount.conf`. |
| `sequentialUsbDriveStartup.sh` | The full "enable → trigger a mount scan → disable" routine: enables `usbmount`, touches each `/dev/sdX` to wake it and let the service mount it, sleeps for the mounts to settle, then disables `usbmount` again. |

The core of `mountusbbylabel.sh` is simple and worth knowing:

```bash
for dev in $(ls -1 /dev/disk/by-label/* | grep -v EFI) ; do
    label=$(basename $dev)
    mkdir -p /media/$label
    $(mount | grep -q /media/$label) || mount $dev /media/$label
done
```

It iterates every labelled block device (skipping `EFI`), creates `/media/<label>` if needed, and mounts the drive there if it isn't already mounted.

> **These scripts live in the `debianusbfileserver` repo, NOT in `primestationone/bin/`.** See §5.

### 3.2 Why auto-mounting is "disabled after startup"

Many PrimeStations run with `usbmount` left **enabled** during boot so drives are mounted automatically, but some owners prefer it **disabled** after startup to avoid it interfering with their own label-based tooling (or with drive setup / filesystem work). The `ENABLED=0` state is why a drive you plug in mid-session **does not** auto-mount on its own.

The label scripts handle both worlds:
- **Startup:** run `sequentialUsbDriveStartup.sh` (from `/etc/rc.local`) to auto-mount everything by label, then disable `usbmount`.
- **Hot-plug:** run `mountusbbylabel.sh` by hand whenever you add a drive.

---

## 4. Connecting a new drive without restarting (step-by-step)

This is the workflow you'll use often. Do this **any time** you plug in a new (or previously removed) USB drive, while the system stays powered on.

1. **Physically connect** the drive to the Pi.
2. **Open a root shell** over SSH (or at the console):
   ```bash
   sudo -i
   ```
3. **(Optional but recommended) Give the drive a clear volume label**, so its mount point is self-explanatory. For an `ext4` drive named `PLEX`:
   ```bash
   sudo e2label /dev/sdX1 PLEX
   ```
   For a `vfat`/FAT32 drive:
   ```bash
   sudo fatlabel /dev/sdX1 PLEX
   ```
   > Replace `/dev/sdX1` with the drive's actual partition device (see step 4). Replug the drive after re-labeling so the system picks up the new label.
4. **Find the drive's device and label:**
   ```bash
   ls -1 /dev/disk/by-label/
   ```
   You should see the drive (e.g. `PLEX`). You can also confirm the raw device with:
   ```bash
   lsblk -f
   ```
5. **Mount everything by label:**
   ```bash
   mountusbbylabel.sh
   ```
6. **Verify it worked:**
   ```bash
   ls /media/
   mount | grep /media
   ```
   Your drive should be mounted (or symlinked) at **`/media/PLEX`** and readable from your file shares / Plex.

7. **Confirm it on the network** — the Samba/`smb` file shares and Plex libraries should now see the new media under `/media/PLEX`. (You may need to trigger a Plex library scan from the Plex web UI.)

> **If a drive doesn't appear:** run the full "sequential" routine, which re-enables the service and forces a re-scan:
> ```bash
> sequentialUsbDriveStartup.sh
> ```
> Then disable the service again if you keep it off:
> ```bash
> disableusbmountservice.sh
> ```

---

## 5. Where does all this live?

- **The by-label scripts are NOT in this repo.** They come from the companion project:
  - Repo: <https://github.com/free5ty1e/debianusbfileserver>
  - Installed on the Pi by: [`bin/installDebianUsbFileServer.sh`](../bin/installDebianUsbFileServer.sh)
  - Typical install path on the Pi: `~/debianusbfileserver/scripts/`
- **`usbmount` config** on the Pi: `/etc/usbmount/usbmount.conf` (repo reference copies in `reference/etc/usbmount/`).
- **`usbmount` hooks** installed by the file-server repo:
  - `mount.d/02_create_label_symlink` → creates `/media/<label>` symlink on mount.
  - `umount.d/01_remove_label_symlink` → removes it on unplug.

### Note on `bin/installDebianUsbFileServer.sh`

This script (in `primestationone/bin/`) clones the file-server repo and runs its installer. It also gives you Samba (`smb`), `vsftpd`, and the Plex media server bits used to serve your drives on the network. If you can't find any by-label scripts on the Pi, re-run this installer to (re)populate them.

---

## 6. Related scripts & files in this repo

| Path | Purpose |
| --- | --- |
| `bin/installDebianUsbFileServer.sh` | Installs the companion `debianusbfileserver` repo (by-label mounts + Samba + FTP + Plex). |
| `bin/installPlexMediaServer.sh` | Installs/configures the Plex media server. |
| `bin/01_retropie_copyroms` | A `usbmount` `mount.d` hook (RetroPie's) that syncs ROMs from a mounted drive into `~/RetroPie/roms` and mirrors the ROM folder structure. |
| `bin/usbRootFilesystemSetup.sh`, `bin/usbGuidRootFilesystemSetup.sh`, `bin/switchFromUsbBackToSdCardRootFilesystem.sh`, `bin/switchFromSdCardBackToUsbRootFilesystem.sh` | Moving the **root filesystem** onto/off of a USB drive (a different concern from mounting media drives — see `reference/txt/usbinstall.md`). |
| `bin/usbSda1ExpandFilesystem.sh` | Expands the first partition of a USB boot/root drive. |
| `reference/txt/installfresh.md` | Explains the classic conflict between RetroPie `usbromservice` and the file-server's label mounting, and how to resolve it by editing `usbmount.conf` `FILESYSTEMS`/`MOUNTOPTIONS`. |
| `reference/etc/usbmount/` | Reference copies of `usbmount.conf` and the `mount.d` / `umount.d` hooks. |

---

## 7. Troubleshooting — exFAT mount errors

If mounting an **exFAT** drive fails or errors with FUSE output, you'll typically see something like:

```
sudo mount /dev/sdc1 /media/usb2
FUSE exfat 1.3.0
WARN: volume was not unmounted cleanly.
ERROR: fsync failed: Remote I/O error.
```

This output tells us two distinct things. Diagnose them in order:

### 7.1 Step 1 — "volume was not unmounted cleanly" (dirty filesystem)

This is just the exFAT **dirty flag**. It usually means the drive was unplugged or powered off while still mounted (common with externally powered enclosures that shut down with the TV/device, or hot-removal without `umount`). It is **not** fatal, but it must be cleared before the drive will mount cleanly.

Check and repair the filesystem (make sure the drive is **not** mounted first):

```bash
sudo fsck.exfat /dev/sdc1        # fuse-exfat / exfat-utils
# or, on newer systems using the kernel driver:
sudo exfatfsck /dev/sdc1
```

If `fsck.exfat` is not installed:

```bash
sudo apt-get install exfat-utils      # for fsck.exfat
# or
sudo apt-get install exfat-fuse       # for the FUSE driver / tools
```

After a clean check, try mounting again. If it now mounts, great — it was just the dirty flag.

> On many systems the kernel exFAT driver and the FUSE driver are alternatives. You can check which one handles exFAT with:
> ```bash
> cat /proc/filesystems | grep exfat
> ```
> `fuse`-based mounting produces the `FUSE exfat 1.x.y` banner you saw. The `exfat` (kernel) driver mounts silently and is generally more stable — see §7.2 for how to prefer it.

> **⚠️ Important:** If `fsck.exfat` / `exfatfsck` **fails with the exact same `ERROR: fsync failed: Remote I/O error.`**, that is a huge clue — skip straight to §7.2. A filesystem tool that can *read* the volume but cannot *write* its fix back to disk is telling you the problem is on the **write path / hardware**, not in the filesystem. See the real-world case in §7.3.

### 7.2 Step 2 — "ERROR: fsync failed: Remote I/O error" (the real problem)

This is the important one. **`Remote I/O error` during a write/`fsync` means the device dropped off the bus mid-write** — a physical-level I/O failure, not a filesystem logic error. You will usually *also* see the drive re-enumerating (e.g. a new `/dev/sdX`, or `dmesg` reporting a USB reset).

Most common causes, in order of likelihood:

1. **The Raspberry Pi 4 USB3 "UAS" driver bug.** The Pi 4's USB3 controller has a known, buggy UAS (USB Attached SCSI) driver that causes exactly these `Remote I/O error` disconnects on many USB3 enclosures. You are likely already aware of this — your own `debianusbfileserver` repo contains diagnostic screenshots:
   - `reference/pi4usb3fileserver2drivesUsingBuggyUasDriver.png`
   - `reference/pi4usb3fileserverAllDrivesUsingQuirksToForceUsbStorageDriver.png`

   **Fix:** force the enclosure off UAS and onto the stable `usb-storage` driver via a kernel `quirks` module parameter. Add to `/boot/config.txt`:
   ```
   # e.g. for a JMS578 enclosure (check lsusb for YOUR vendor:product):
   [pi4]
   dtoverlay=disable-bt
   ```
   ...and add the quirk to the boot command line in `/boot/cmdline.txt`:
   ```
   usb-storage.quirks=VENDOR:PRODUCT:u
   ```
   Replace `VENDOR:PRODUCT` with the USB ID from `lsusb` (e.g. `152d:0578:u` for JMS578), then reboot. This disables UAS for that device only and routes it through `usb-storage`, which is far more reliable on the Pi 4.

2. **Poor USB cable / connector / port.** A marginal cable or a flaky USB3 port causes intermittent disconnects under load. Try a different (ideally short, high-quality) cable and a different port, especially a **USB2 port** as a quick test to confirm the theory.

3. **Insufficient power.** If the enclosure has no external power, a spinning HDD can brown-out the Pi's USB power during heavy writes. Use the official power supply and/or power the enclosure externally.

4. **The drive/enclosure itself is failing.** Run a SMART check if it's SATA/USB:
   ```bash
   sudo smartctl -a /dev/sdc
   ```
   Look for `Reallocated_Sector_Ct`, `Pending_Sector`, or high error counts. (The file-server repo also has `drivesmartstats.sh` / `drivetestbadblocks*.sh` helpers.)

### 7.3 Real-world case: `exfatfsck` fails with the same error

```
pi@primestationonepi4 ~ $ sudo exfatfsck /dev/sdc1
exfatfsck 1.3.0
Checking file system on /dev/sdc1.
WARN: volume was not unmounted cleanly.
ERROR: fsync failed: Remote I/O error.
File system checking stopped. ERRORS FOUND: 1, FIXED: 0.
```

**Analyzing the result:**

- `exfatfsck` successfully **read** the volume: it detected the dirty flag and walked the filesystem structure. So the **read path works**, and the filesystem itself is *probably* fine (just flagged dirty).
- But it then tried to **write** its fix (clearing the dirty bit / repairing) and that write failed with `Remote I/O error` on `fsync`. `fsync` guarantees the data hit the physical disk; failing here means **the write never made it off the bus**.

**Conclusion: this is a write-path hardware failure, not a filesystem problem.** The drive is effectively *read-only* to the system right now. A tool can't "fix" a dirty flag it isn't allowed to write. Hammering it with more `fsck` runs won't help and can risk the drive if it's genuinely failing.

### 7.4 Working through this case — next diagnostic steps

Run these **in order**. Each narrows the cause.

```bash
# 1. Is the device flagged read-only by the kernel? (cheap, safe)
blockdev --getro /dev/sdc
#     0 = writable, 1 = read-only. If 1, the bridge/driver forced it read-only.

# 2. What does the kernel say is actually failing? Look for UAS/SCSI/USB resets.
dmesg | tail -80
dmesg | grep -iE "uas|usb-storage|I/O error|reset|sd 2:0:0:0|sdc" | tail -40

# 3. Is the drive being handled by UAS (buggy on Pi4) or usb-storage?
#    Look in dmesg for "uas" vs "usb-storage" binding the device.

# 4. Identify the USB device so we can build a quirk entry.
lsusb            # note the VENDOR:PRODUCT of the enclosure
```

What the answers tell you:

| Finding | Meaning / next action |
| --- | --- |
| `blockdev` returns `1` (read-only) | The USB bridge has locked the drive read-only (many bridges do this after detecting errors). This is protective, not the root cause. Power-cycle the enclosure and fix the underlying bus issue first. |
| `dmesg` shows UAS + `I/O error` / resets on a **USB3** port | **The Pi 4 UAS bug** — most likely. Apply the quirk in §7.2 item 1 and reboot. |
| `dmesg` shows the device repeatedly disconnecting/re-enumerating | Cable, port, or power. Try a USB2 port / different cable (see §7.2 items 2–3). |
| `lsusb` shows a **USB3 (500M/5G)** connection but `dmesg` shows UAS failures | Force `usb-storage` via the quirks parameter. |

**If step 4 `lsusb` identifies the enclosure** (this is the most probable fix):

```bash
# e.g. 152d:0578 is a JMicron JMS578 USB3-SATA bridge:
# add to /boot/config.txt under [pi4]:
#   dtoverlay=disable-bt          (if you don't use BT; frees USB)
# add to /boot/cmdline.txt (append, keep on ONE line):
#   usb-storage.quirks=152d:0578:u
sudo reboot
```

After reboot: unplug/replug the drive, then re-run the filesystem repair:

```bash
sudo exfatfsck /dev/sdc1
sudo mountusbbylabel.sh
```

**If it still fails after the UAS quirk,** the cause is almost certainly **cable → power → the drive/enclosure itself**. Work down §7.2 items 2–4 (try another cable/port, check power, then `smartctl`).

> **Bottom line:** When the *filesystem checker itself* can't write, stop trying to repair the filesystem and fix the **storage bus first**. On a Pi 4, the far-and-away most common culprit is the UAS driver. Solve that (quirk + reboot), and the "dirty volume" usually becomes writable and clears cleanly on the next `fsck`.

### 7.5 Resolved: analyzing the actual diagnostic output

The case was fully diagnosed with the commands from §7.4. Here is the output analysis, so you can recognize the same pattern later.

**Diagnostic output gathered:**

```bash
sudo blockdev --getro /dev/sdc     # → 0 (writable, not forced read-only)
```

```bash
# kernel command line (from dmesg), note the quirks ALREADY present:
# usb-storage.quirks=0bc2:3322:u,1058:25fb:u,0bc2:a0a1:u,0bc2:50a2:u

# dmesg excerpt:
usb-storage 2-2.4.3:1.0: Quirks match for vid 1058 pid 25fb: 800000   # WD drive OK
usb-storage 2-2.4.4:1.0: Quirks match for vid 1058 pid 25fb: 800000   # WD drive OK
usb-storage 2-2.4.1:1.0: USB Mass Storage device detected             # failing Seagate (NO quirk line)
usb 2-2.4.1: reset SuperSpeed Gen 1 USB device number 7 using xhci_hcd
usb 2-2.4.1: reset SuperSpeed Gen 1 USB device number 7 using xhci_hcd
usb 2-2.4.1: reset SuperSpeed Gen 1 USB device number 7 using xhci_hcd
```

```bash
# lsusb (Bus 002 = USB3):
Bus 002 Device 007: ID 0bc2:3330 Seagate RSS LLC     # ← the failing drive
Bus 002 Device 005: ID 1058:25fb Western Digital     # working
Bus 002 Device 004: ID 1058:25fb Western Digital     # working
Bus 002 Device 003: ID 05e3:0626 Genesys Logic       # USB3 hub
Bus 002 Device 002: ID 05e3:0626 Genesys Logic       # USB3 hub (daisy-chained)
```

**Reading the evidence — point by point:**

| Observation | What it means |
| --- | --- |
| `blockdev --getro` = `0` | The device is **writable** at the block layer. Not a write-protect lock. |
| WD drives (`1058:25fb`) show `Quirks match` and mount cleanly | The Pi 4 **UAS quirk is already in effect** for them, and they are happy on the same hub chain. |
| The failing Seagate (`0bc2:3330`) is **not** in the quirks list **and** shows **no** `Quirks match` line | It's on `usb-storage` but explicitly un-quirked. |
| Three `reset SuperSpeed Gen 1 USB device` events during the `fsck`'s writes | The drive's **USB3 (5 Gbps) link is dropping mid-write** — the writes fail and surface as `Remote I/O error`. |
| Seagate is behind two `05e3:0626` Genesys USB3 hubs in series (`2-2.4.1`) | It's **daisy-chained through USB3 hubs** on a SuperSpeed link. |
| Reads work, writes fail | Consistent with a **link reset during write** rather than a filesystem or drive-failure problem. |

**Conclusion.** This was **not** a filesystem error and **not** the classic Pi 4 UAS bug (UAS is already disabled via quirks). It was **SuperSpeed (USB3) link instability** on the Seagate drive's connection — made much more likely by being daisy-chained through USB3 hubs — causing **link resets during writes**. The `fsync failed: Remote I/O error` was the symptom; the dirty flag was merely a consequence of the interrupted writes.

**Fixes that actually apply here (in order):**

1. **Drop the drive to USB2** (the definitive test & fix). The resets are specifically *SuperSpeed* link resets; USB2 (HighSpeed) uses a far more stable link. Plug the drive into a **USB2 port**, or if you must keep it on USB3, reduce the hub chain:
   ```bash
   # Connect the Seagate directly to a Pi USB3 port (bypassing the daisy-chained hubs)
   # or into a USB2 port. Then:
   sudo exfatfsck /dev/sdc1
   sudo mountusbbylabel.sh
   ```
2. **Reduce / remove the daisy-chained USB3 hubs.** Two `05e3:0626` hubs in series at 5 Gbps is a common source of SuperSpeed instability. Connect the drive directly to a Pi USB3 port, or put the hubs behind USB2.
3. **Add the Seagate to the quirks list as belt-and-suspenders** (harmless, in case the enclosure can also negotiate UAS):
   ```
   # append to the usb-storage.quirks=... in /boot/cmdline.txt:
   0bc2:3330:u
   ```
4. If it still resets **directly on a USB2 port**, then suspect **cable → power → the drive/enclosure** (SMART check) rather than the bus.

> **Recap of the whole investigation:** dirty flag → `fsck` failed to write → therefore hardware/bus, not filesystem → quirks already applied for most drives → the one drive missing from the quirks and sitting on an unstable SuperSpeed link was the culprit → fix by isolating that drive. **Lesson: when a *filesystem checker* can't write, and UAS is already quirked, look at the physical USB link (hub / USB3 vs USB2 / the drive's own adapter / cable / power), not the filesystem.**

### 7.6 All drives on the same powered USB3 hub — is it the drive's adapter?

**Scenario:** all three drives hang off the **same powered USB3 hub**, connected directly to the Pi's USB3 port. The two WD drives mount and write fine; only the Seagate (`0bc2:3330`) resets on writes.

**Immediate conclusion:** because the *identical* hub + port + power work for the WD drives, the hub, the port, and the Pi are effectively ruled out. The problem is **specific to the Seagate** — almost certainly its **own USB→SATA bridge/adapter** (or the drive/enclosure), which is a *different adapter* from the WD drives. So to answer the question directly: **yes, a different USB adapter (the Seagate's) is the prime suspect.**

> Note on the "two `05e3:0626` hubs" from `lsusb`: that is the **internal topology of the single powered hub** (many multi-port USB3 hubs enumerate as an internal hub tree), not a literal daisy-chain you need to dismantle. It reinforces that everything is behind one hub.

**Confirm it before replacing anything — a quick A/B isolation test:**

1. **Seagate directly on the Pi, bypassing the hub.**
   Unplug the Seagate from the hub and plug it into the Pi's **USB3 port directly** (no hub). Then:
   ```bash
   sudo exfatfsck /dev/sdc1
   sudo mountusbbylabel.sh
   ```
   - **Works** → the hub's relationship to this drive (power/port on the hub) was the issue. Try the Seagate on a *different hub port*; if it's a 2.5" portable drive, its spin-up on a shared hub may be borderline.
   - **Still fails** → the Seagate itself, continue below.

2. **Seagate on a USB2 port (or force USB2).**
   The resets are specifically *SuperSpeed* resets. Plug the Seagate into a **USB2 port** and retry the same commands.
   - **Works** → the drive's **bridge can't hold a stable SuperSpeed (5 Gbps) link** → its USB adapter is the culprit.

3. **If steps 1–2 confirm the bridge:** replace the Seagate's USB adapter/cable.
   - If the Seagate uses a **detachable USB→SATA adapter/cable**, swap in a known-good USB3 adapter (ideally a UASP-capable one, and add `0bc2:3330:u` to the quirks list so it uses `usb-storage`).
   - If it's an **integrated enclosure**, the practical fix is to use that bare SATA drive in a **different enclosure/adapter**. Before discarding the drive, verify it's healthy with a SMART check so you don't blame a good drive:
     ```bash
     sudo smartctl -a /dev/sdc
     ```
   - As a stopgap that needs no hardware: run the drive **on USB2** (fully stable, just 480 Mbps instead of 5 Gbps — fine for file/Plex serving).

> **Bottom line for "one powered hub, only one drive fails":** it's not your hub or your Pi. Isolate that one drive (direct → USB2 → swap adapter → SMART). The dirty exFAT flag clears itself once the writes actually succeed.

---

## 8. Troubleshooting quick-reference

| Symptom | Likely cause / fix |
| --- | --- |
| Drive doesn't appear after plugging in | `usbmount` is disabled (`ENABLED=0`) — run `mountusbbylabel.sh` (or `sequentialUsbDriveStartup.sh`). |
| `/media/PLEX` doesn't exist | Drive has no label, or you need to re-run the by-label mount after labeling. Give it a label (§4 step 3) and rerun. |
| ROMs don't sync to RetroPie | The `01_retropie_copyroms` hook needs the drive's filesystem in `FILESYSTEMS` in `usbmount.conf`, and the drive needs a `roms/` folder. |
| By-label mount conflicts with file-server drive | See `reference/txt/installfresh.md`: e.g. remove `ext4` from `FILESYSTEMS` in `usbmount.conf` so `usbmount` ignores your `ext4` file-server drives and leaves them to the label script. |
| "Permission denied" reading the drive | The hooks `chown`/`chmod` media dirs for `pi:pi` (`installAutoMountUsbByLabelToUsbmount.sh` runs `sudo chown pi:pi /media/*`). Re-run that or fix ownership. |
| exFAT mount fails: `WARN: volume was not unmounted cleanly.` + `ERROR: fsync failed: Remote I/O error.` | See [§7 Troubleshooting — exFAT mount errors](#7-troubleshooting--exfat-mount-errors). Likely a dirty flag **plus** a Pi 4 UAS/USB write-path disconnect. If `fsck`/`exfatfsck` also fails to write, it's hardware, not the filesystem: apply a `usb-storage.quirks` entry to disable UAS and reboot, then re-run `fsck`. |

See also the diagram in [`excalidraw/usb-mounting-flow.excalidraw.md`](excalidraw/usb-mounting-flow.excalidraw.md) for a visual walkthrough of the whole flow.