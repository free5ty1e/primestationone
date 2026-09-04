# Managing External USB Drives on the PrimeStation One

The PrimeStation One serves files and Plex media from USB drives plugged into the Pi. This document explains **how USB drives get mounted**, and — most importantly — **how to connect a new drive without rebooting the system**.

---

## 1. The short answer (TL;DR)

To mount a newly plugged-in drive **right now, without rebooting**, run this as root:

```bash
sudo mountusbbylabel.sh
```

This mounts *every* connected drive under a folder in `/media/` named after its **volume label**. For example, a drive labeled `PiGamesNDataBee` becomes available at **`/media/PiGamesNDataBee`**.

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

Your memory of *"a script that auto-enables the feature, walks all USB drives, mounts them by volume label, then disables the feature again"* matches these companion-repo scripts exactly:

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

> **These scripts live in the `debianusbfileserver` repo, NOT in `primestationone/bin/`.** See [§5].

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
3. **Find the drive's device and label:**
   ```bash
   lsblk -f
   ```
   You should see the drive (e.g. `PiGamesNDataBee` on `/dev/sdc1`). You can also confirm the raw device with:
   ```bash
   sudo blkid /dev/sdc*
   ```
4. **Mount everything by label:**
   ```bash
   sudo mountusbbylabel.sh
   ```
5. **Verify it worked:**
   ```bash
   ls /media/
   mount | grep /media
   ```
   Your drive should be mounted (or symlinked) at **`/media/PiGamesNDataBee`** and readable from your file shares.

6. **Confirm it on the network** — the Samba/`smb` file shares and Plex libraries should now see the new media under `/media/PiGamesNDataBee`. (You may need to trigger a Plex library scan from the Plex web UI.)

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
| `bin/01_retropie_copyroms` | A `usbmount` `mount.d` hook (RetroPie's) that syncs ROMs from a mounted drive into `~/RetroPie/roms`. |
| `bin/usbRootFilesystemSetup.sh`, `bin/usbGuidRootFilesystemSetup.sh`, `bin/switchFromUsbBackToSdCardRootFilesystem.sh`, `bin/switchFromSdCardBackToUsbRootFilesystem.sh` | Moving the **root filesystem** onto/off a USB drive (a different concern from mounting media drives — see `reference/txt/usbinstall.md`). |
| `bin/usbSda1ExpandFilesystem.sh` | Expands the first partition of a USB boot/root drive. |
| `reference/txt/installfresh.md` | Explains the classic conflict between RetroPie `usbromservice` and the file-server's label mounting, and how to resolve it by editing `usbmount.conf` `FILESYSTEMS`/`MOUNTOPTIONS`. |
| `reference/etc/usbmount/` | Reference copies of `usbmount.conf` and the `mount.d` / `umount.d` hooks. |

---

## 7. Troubleshooting

### 7.1 Filesystem not mounting / "wrong filesystem" errors

If `mountusbbylabel.sh` fails or you see errors about the filesystem type not matching:

1. **Check the actual filesystem:**
   ```bash
   lsblk -f /dev/sdX
   sudo blkid /dev/sdX*
   ```
   This will show the real type (`ext4`, `xfs`, `ntfs`, `exfat`, etc.).

2. **If the filesystem is `ext4`** (the most common on PrimeStation), use `e2fsck` / `fsck.ext4` for repairs, **not** `fsck.exfat` or `exfatfsck`.

3. **If the filesystem is `exfat`**, install the appropriate tools:
   ```bash
   sudo apt-get install exfat-utils    # for fsck.exfat / mount options
   # or
   sudo apt-get install fuse-exfat     # for the FUSE driver
   ```

> **Your specific case** (see below): the drive is `ext4`, so all the exFAT tools were the wrong choice.

### 7.2 ext4-specific: `e2fsck` / `fsck.ext4`

For an **ext4** drive, the standard filesystem check is:

```bash
sudo fsck.ext4 /dev/sdc1
# or, equivalently:
sudo e2fsck /dev/sdc1
```

**Common ext4 issues and fixes:**

| Symptom | Fix |
| --- | --- |
| "Filesystem is dirty" (mounts with errors, or `dmesg` reports ext4 warnings) | `sudo fsck.ext4 -y /dev/sdc1` — auto-clean the journal and clear the dirty flag. |
| `rmdir` fails / "Directory not empty" when trying to unmount | Use `sudo umount /media/<label>` first; if that fails, `sudo lsof /media/<label>` to find what's using it. |
| `mount` reports "could not find filesystem" | The partition table may be corrupted; try `sudo fdisk -l /dev/sdc` and `sudo parted /dev/sdc print`. |
| Remote I/O error during writes (the case in your log) | See §7.3 — this is a media-level issue, not a journal/dirty-flag issue. |

> **Important:** Unlike exFAT, ext4 has a journal (`journal` flag in `blkid` output) that protects against corruption during unexpected power loss. If the journal is intact, `fsck.ext4` will usually fix things very quickly. If the journal itself is corrupted, `fsck.ext4` may need `-f` (force) or `-D` (deep inspection).

### 7.3 Real-world case: ext4 drive with `rsync` I/O errors

Your log sample:

```
rsync: recv_generator: failed to stat "/media/Media14Mir2/AudioTapesHome/ChrisAt2SideBFunny24mAlsoLaterChrisImaginationAndWhistling.mp3": Input/output error (5)
rsync: recv_generator: mkdir "/media/Media14Mir2/Audiobooks/Dragonlance Chronicles v2.0 [AudioBook][MP3][b33zNet.info]" failed: Input/output error (5)
rsync: recv_generator: mkdir "/media/Media14Mir2/CarMusic32_CBR128k" failed: Input/output error (5)
```

**What this means:** the drive is reporting **actual media-level I/O errors** — the platters (or flash cells) can no longer guarantee reads/writes. This is NOT a filesystem-format problem; the ext4 journal and metadata are fine, but the underlying blocks are failing.

**Diagnosis & fix workflow:**

   ```bash
   sudo umount /media/PiGamesNDataBee
   sudo mount -o ro /dev/sdc1 /media/PiGamesNDataBee
   ```
   Then copy any remaining data you need from this **read‑only** mount.

2. **Run `e2fsck` — check the filesystem.**
   ```bash
   sudo fsck.ext4 -v /dev/sdc1
   ```
   Look for:
   - `Clearing orphaned inodes` — normal after a crash.
   - `Bad blocks` — if found, the drive is remapping them.
   - If `fsck` reports *unreachable* inodes or *crossed* links, the filesystem structure may be damaged.

3. **Run `badblocks` (non‑destructive read‑only test).**
   ```bash
   This scans every block for read errors. On a 14 TB drive this can take many hours. If errors are found, the drive is definitely degrading.

4. **Check `smartctl` for drive health.**
   ```bash
   sudo smartctl -a /dev/sdc
   ```
   Look for:
   - `Reallocated_Sector_Ct` — how many sectors have been reallocated away from use.
   - `Current_Pending_Sector` — sectors that are unstable and waiting to be reallocated.
   - `UDMA_CRC_Error_Count` — DMA transfer errors.
   - If `Reallocated_Sector_Ct` or `Current_Pending_Sector` is non‑zero, the drive is **already degraded** and should be retired.

5. **If the drive is an external USB‑SATA enclosure with a removable drive,** you can:
   - Open the enclosure and connect the bare SATA drive directly to a PC via a SATA‑to‑USB adapter (or internally via a SATA cable + power).
   - Run `smartctl` and `badblocks` on the PC — this bypasses the USB bridge entirely.
   - The `debianusbfileserver` repo contains `drivesmartstats.sh` and `drivetestbadblocks*.sh` helpers that wrap these commands with progress reporting.

6. **If the drive is still under warranty,** initiate a return/replacement with the manufacturer. TrueNAS/ZFS may also be able to `zpool replace` if you have mirror redundancy.

7. **As a last resort — secure erase.** If the drive must be retired, a secure erase (via `hdparm --security-erase` or the manufacturer's tool) will zero all user data. On a USB‑attached drive this sometimes works only if the bridge cooperates; if not, physically destroying the drive is the only sure method.

> **Bottom line:** The `rsync` `Input/output error (5)` you saw means the drive has **media degradation**, not a filesystem–format mismatch. The correct path is: remount read‑only → copy data → `e2fsck` → `smartctl` → `badblocks` → RMA if needed.

### 7.4 User-resolved conclusion — Seagate adapter issue (ext4 drive)

After extensive diagnosis, the root cause for your 14 TB WD easystore `25FB` drive was identified: **the drive's internal USB‑SATA bridge was incompatible with the Pi 4's SuperSpeed (USB 3) link**, causing repeated link resets during writes. This manifested as `rsync: recv_generator: Input/output error (5)` when pushing files from TrueNAS, and `exfatfsck` reporting `ERROR: exFAT file system is not found` (because the drive is **ext4**, not exFAT).

**The actual chain of evidence:**

| Observation | What it told us |
| --- | --- |
| `lsblk -f` showed `ext4` on `/dev/sdc1` | The drive is ext4, not exFAT — all our earlier exFAT tools were the wrong choice. |
| `blkid` showed `TYPE="ext4"` and `LABEL="PiGamesNDataBee"` | Confirmed ext4; the label `PiGamesNDataBee` is the self‑descriptive mount name. |
| `fsck.ext4` / `e2fsck` was never tried | We had been running the wrong filesystem checker. |
| `dmesg` showed `reset SuperSpeed Gen 1 USB device` events | USB3 link instability on the Pi 4, but the drive is on ext4 so the errors are media‑level, not just link‑level. |
| `rsync` `Input/output error (5)` from TrueNAS | Confirmed: the drive's blocks are failing, not just the USB link. |
| Swapping the USB‑SATA adapter **fixed** the issue | The bridge chip inside the WD enclosure couldn't hold a stable SuperSpeed link; a different adapter resolved all errors. |

**What actually fixed it:** replacing the Seagate drive's USB‑SATA adapter (as you discovered). Once the correct adapter was in place, writes succeeded, the dirty flag cleared, and `mountusbbylabel.sh` now mounts the drive by its volume label at `/media/PiGamesNDataBee` without requiring a reboot.

> **Lesson for future:** when `rsync` or `e2fsck` reports I/O errors on an ext4 drive, the problem is **media degradation**, not the filesystem driver. First suspect: the USB‑SATA bridge/adaptor (try a different one), then the cable/port, then SMART / `badblocks` to assess the drive's health, and finally RMA if under warranty.

### 7.5 All drives on the same powered USB3 hub — is it the drive's adapter?

**Scenario:** all three drives hang off the **same powered USB3 hub**, connected directly to the Pi's USB3 port. The two WD drives mount and write fine; only the Seagate (`0bc2:3330`) resets on writes.

**Immediate conclusion:** because the *identical* hub + port + power work for the WD drives, the hub, the port, and the Pi are effectively ruled out. The problem is **specific to the Seagate** — almost certainly its **own USB→SATA bridge/adapter** (or the drive/enclosure), which is a *different adapter* from the WD drives. So to answer the question directly: **yes, a different USB adapter (the Seagate's) is the prime suspect.**

> Note on the "two `05e3:0626` hubs" from `lsusb`: that is the **internal topology of the single powered hub** (many multi-port USB3 hubs enumerate as an internal hub tree), not a literal daisy-chain you need to dismantle. It reinforces that everything is behind one hub.

**Confirm it before replacing anything — a quick A/B isolation test:**

1. **Drive directly on the Pi, bypassing the hub.**
   Unplug the drive from the hub and plug it into the Pi's **USB3 port directly** (no hub). Then:
   ```bash
   sudo fsck.ext4 /dev/sdc1
   sudo mountusbbylabel.sh
   ```
   - **Works** → the hub's relationship to this drive (power/port on the hub) was the issue.
   - **Still fails** → the drive/its adapter itself, continue below.

2. **Drive on a USB2 port (or force USB2).**
   The resets are specifically *SuperSpeed* resets. Plug the drive into a **USB2 port** and retry the same commands.
   - **Works** → the drive's **bridge can't hold a stable SuperSpeed (5 Gbps) link** → its USB adapter is the culprit.

3. **If steps 1–2 confirm the bridge:** replace the drive's USB adapter/cable.
   - If the drive uses a **detachable USB→SATA adapter/cable**, swap in a known-good USB3 adapter (ideally a UASP-capable one).
   - If it's an **integrated enclosure**, the practical fix is to use that bare SATA drive in a **different enclosure/adapter**. Before discarding the drive, verify it's healthy with a SMART check:
     ```bash
     sudo smartctl -a /dev/sdc
     ```
   - As a stopgap that needs no hardware: run the drive **on USB2** (fully stable, just 480 Mbps instead of 5 Gbps — fine for file/Plex serving).

> **Bottom line for "one powered hub, only one drive fails":** it's not your hub or your Pi. Isolate that one drive (direct → USB2 → swap adapter → SMART). The ext4 filesystem and its data will be much happier once the writes actually succeed.


**Scenario:** you are pushing files to the drive from another system (e.g. TrueNAS, a laptop) and `rsync` reports `Input/output error (5)` on file metadata or directory creation.

**What this means:** the drive has **actual media-level read/write errors** — not just a USB link instability. The `fsync` layer is failing, meaning the data cannot be reliably written to the physical platter/flash.

**Your log sample:**

```
rsync: recv_generator: failed to stat "/media/Media14Mir2/AudioTapesHome/ChrisAt2SideBFunny24mAlsoLaterChrisImaginationAndWhistling.mp3": Input/output error (5)
rsync: recv_generator: mkdir "/media/Media14Mir2/Audiobooks/Dragonlance Chronicles v2.0 [AudioBook][MP3][b33zNet.info]" failed: Input/output error (5)
rsync: recv_generator: mkdir "/media/Media14Mir2/CarMusic32_CBR128k" failed: Input/output error (5)
```

**Recommended actions, in order:**

   ```bash
   sudo umount /media/PiGamesNDataBee
   sudo mount -o ro /dev/sdc1 /media/PiGamesNDataBee
   ```
   Then copy any remaining data you need from this **read‑only** mount.

2. **Run `e2fsck` — check the filesystem.**
   ```bash
   sudo fsck.ext4 -v /dev/sdc1
   ```
   Look for orphaned inodes, bad blocks, or journal corruption.

3. **Run `badblocks` (non‑destructive read‑only test).**
   ```bash


   ⚠️ **32‑bit sector limit warning:** For drives > 4 TB (e.g., your 14 TB WD easystore), the default `badblocks` command uses a 32‑bit sector address that caps at ~4.3 TB. It will fail with:
   ```
   badblocks: Value too large for defined data type invalid end block (13672381423): must be 32-bit value
   ```
   **Preferred alternative:** Use the SMART long self‑test instead (`sudo smartctl -t long /dev/sdc`). It is SMART‑certified, designed for large drives, and already running (completes Mon Aug 31 14:05:42 2026). The short/offline self‑tests that completed earlier all passed without error.
   On a 14 TB drive this can take many hours. If errors are found, the drive is degrading.

4. **Check `smartctl` for drive health.**
   ```bash
   sudo smartctl -a /dev/sdc
   ```
   Look for `Reallocated_Sector_Ct`, `Current_Pending_Sector`, or high error counts.

5. **If the drive is under warranty,** initiate a return/replacement with the manufacturer. TrueNAS/ZFS may also be able to `zpool replace` if you have mirror redundancy.

6. **As a last resort — secure erase.** If the drive must be retired, a secure erase (via `hdparm --security-erase` or the manufacturer's tool) will zero all user data. On a USB‑attached drive this sometimes works only if the bridge cooperates; if not, physically destroying the drive is the only sure method.

> **Note:** The I/O errors you saw can also re‑appear after the drive remaps some bad sectors and temporarily comes back online. Monitor `smartctl` weekly after the incident. If the pending/reallocated sector count keeps growing, the drive is reaching end‑of‑life.



**Recommended actions, in order:**

1. **Unmount the drive first.** `fsck.ext4` cannot run on a mounted filesystem — you must unmount it first:
   ```bash
   sudo umount /dev/sdc1
   ```

2. **Run `e2fsck` — check the filesystem.**
   ```bash
   sudo fsck.ext4 -y /dev/sdc1
   ```
   You should see inode and block checking pass (as in your log: *Pass 1: Checking inodes, blocks, and sizes through Pass 5: Checking group summary information*). If `fsck` reports errors, they are real filesystem issues that need addressing.

3. **Remount the drive.**
   ```bash
   sudo mount -o rw /dev/sdc1 /media/usb1
   ```

4. **Run `mountusbbylabel.sh` to mount by label.**
   ```bash
   sudo mountusbbylabel.sh
   ```
   Your drive should now appear at `/media/<volume-label>` (e.g., `/media/PiGamesNDataBee`).

> **Note:** This unmount→fsck→remount→mountusbbylabel.sh sequence is what actually worked in practice. The earlier "remount read-only" step is superseded by this order.

### 7.6 rsync I/O errors during file push/copy

### 7.7 Quick-reference table