# PrimeStation One — Documentation

This folder is a growing set of documentation for the **PrimeStation One** project — a "ready-to-go" [RetroPie](https://github.com/petrockblog/RetroPie-Setup) retro-gaming setup that runs on a Raspberry Pi 4 / 5 and is built from source over a fresh Raspbian install.

> **Starting point:** the top-level [`README.md`](../README.md) in the repo root explains the project mission, supported systems, install/imaging steps, and the Android control app. This `docs/` folder is where we are consolidating the deep-dive, how-to, and reference material.

## Index

| Document | What it covers |
| --- | --- |
| [`usb-drive-management.md`](usb-drive-management.md) | **How to manage externally connected USB drives** — the by-volume-label mounting system, how to attach a new drive **without rebooting**, and how the startup + hotplug automation fits together. |
| [`scripts-overview.md`](scripts-overview.md) | A high-level tour of the ~320 scripts under `bin/`, grouped by purpose (install, setup, emulator tweaks, networking, backup, PS3/4 controller drivers, etc.). |
| [`excalidraw/usb-mounting-flow.excalidraw.md`](excalidraw/usb-mounting-flow.excalidraw.md) | An **Excalidraw** diagram (open it in [excalidraw.com](https://excalidraw.com) or VS Code) visualizing the USB drive mount flow. |

## Conventions & quick facts

- **User account:** most scripts assume the `pi` user and paths like `~/primestationone`, `~/RetroPie`, `~/debianusbfileserver`.
- **Mount locations:** USB drives are mounted under `/media/`. Two mechanisms do this (see the USB doc for the full story).
- **`bin/` is the script home.** Almost all functionality is exposed as standalone scripts under `bin/`, and many are surfaced in EmulationStation's menus.
- **Companion repositories** referenced by this project:
  - `free5ty1e/debianusbfileserver` — the USB file server + by-label mounting tooling (`bin/installDebianUsbFileServer.sh`).
  - `free5ty1e/primestationone-control-android` — the Android remote-control app.
  - `free5ty1e/primestationone-estheme` — the EmulationStation theme.

## Style notes

- Everything here is **Markdown** (renders on GitHub).
- Diagrams are provided as **Excalidraw** files (`.excalidraw.md`) so they can be edited visually while still reading as Markdown.