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

### 7.3 Suggested workflow for this error

```bash
# 1. Make sure it's not mounted
mount | grep /dev/sdc || true

# 2. Repair the dirty exFAT volume
sudo fsck.exfat /dev/sdc1

# 3. Check for USB-level disconnects / re-enumeration
dmesg | tail -50

# 4. Identify the USB device for a UAS quirk
lsusb

# 5. Remount by label (see §4)
sudo mountusbbylabel.sh
```

If the error persists, apply the UAS quirk (item 1 in §7.2) and reboot — that resolves the majority of Pi 4 USB3 `Remote I/O error` cases.

---

## 8. Troubleshooting quick-reference

| Symptom | Likely cause / fix |
| --- | --- |
| Drive doesn't appear after plugging in | `usbmount` is disabled (`ENABLED=0`) — run `mountusbbylabel.sh` (or `sequentialUsbDriveStartup.sh`). |
| `/media/PLEX` doesn't exist | Drive has no label, or you need to re-run the by-label mount after labeling. Give it a label (§4 step 3) and rerun. |
| ROMs don't sync to RetroPie | The `01_retropie_copyroms` hook needs the drive's filesystem in `FILESYSTEMS` in `usbmount.conf`, and the drive needs a `roms/` folder. |
| By-label mount conflicts with file-server drive | See `reference/txt/installfresh.md`: e.g. remove `ext4` from `FILESYSTEMS` in `usbmount.conf` so `usbmount` ignores your `ext4` file-server drives and leaves them to the label script. |
| "Permission denied" reading the drive | The hooks `chown`/`chmod` media dirs for `pi:pi` (`installAutoMountUsbByLabelToUsbmount.sh` runs `sudo chown pi:pi /media/*`). Re-run that or fix ownership. |
| exFAT mount fails: `WARN: volume was not unmounted cleanly.` + `ERROR: fsync failed: Remote I/O error.` | See [§7 Troubleshooting — exFAT mount errors](#7-troubleshooting--exfat-mount-errors). Usually a dirty flag + a Pi 4 UAS/USB I/O disconnect: run `fsck.exfat`, then apply a `usb-storage.quirks` entry to disable UAS for the enclosure. |

See also the diagram in [`excalidraw/usb-mounting-flow.excalidraw.md`](excalidraw/usb-mounting-flow.excalidraw.md) for a visual walkthrough of the whole flow.