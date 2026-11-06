# Hyprland_Setup

Versioned backups of my Hyprland desktop on Arch Linux. Every commit is a full snapshot that can be restored.

## Stack

| Part | What |
|---|---|
| OS | Arch Linux |
| Compositor | Hyprland 0.57.x (Lua config) |
| Shell / panels | [end-4 illogical-impulse](https://github.com/end-4/dots-hyprland) (Quickshell) |
| Window switcher | hyprshell (switch and overview disabled, see below) |
| Terminal shell | fish |

## Contents

| Folder | Source | Holds |
|---|---|---|
| `hypr/` | `~/.config/hypr` | Hyprland config: keybinds, monitors, rules |
| `quickshell/` | `~/.config/quickshell` | illogical-impulse shell |
| `illogical-impulse/` | `~/.config/illogical-impulse` | Shell settings (`config.json`) |
| `hyprshell/` | `~/.config/hyprshell` | hyprshell config |
| `scripts/` | this repo | Backup/restore scripts and pacman hook |

## Custom changes

- **Alt+Tab / Alt+Shift+Tab** cycle the open workspaces on the monitor under the mouse (`hypr/hyprland/keybinds.lua`, `m+1` / `m-1`).
- **Monitors** use a fallback rule, so any connected display gets its native mode automatically (`hypr/monitors.lua`). Don't use nwg-displays Apply: it overwrites this with fixed, port-based modes.
- **hyprshell** `switch` and `overview` are set to `None`. hyprshell 4.10.8 fails on Hyprland 0.57 ([H3rmt/hyprshell#533](https://github.com/H3rmt/hyprshell/issues/533)). Re-enable once it's fixed.
- Removed a stale `hyprshell gui ...` Alt+Tab bind from `hypr/custom/keybinds.lua`.

## Backup and restore

Snapshots live in `~/Documents/Hyprland_Setup`, which is this repo.

| Action | Command |
|---|---|
| Snapshot now | `hypr-backup` |
| Automatic | Runs before every pacman / yay upgrade (pacman hook) |
| List snapshots | `git -C ~/Documents/Hyprland_Setup log --oneline` |
| Restore | `hypr-restore <id>` then Ctrl+Super+R |
| Push to GitHub | `git -C ~/Documents/Hyprland_Setup push` |

`hypr-restore` snapshots the current state first, so a restore can be undone.

## Install on a new machine

Needs Hyprland, Quickshell and illogical-impulse installed first.

```fish
git clone https://github.com/RoshanDan4817/Hyprland_Setup.git ~/Documents/Hyprland_Setup
cd ~/Documents/Hyprland_Setup
mkdir -p ~/.local/bin; and cp scripts/hypr-backup scripts/hypr-restore ~/.local/bin/; and chmod +x ~/.local/bin/hypr-*
sudo mkdir -p /etc/pacman.d/hooks; and sudo cp scripts/00-hypr-config-backup.hook /etc/pacman.d/hooks/
hypr-restore HEAD
```

The hook runs as user `roshand`. Edit its `Exec` line for a different user.

## If an update breaks things

1. `git -C ~/Documents/Hyprland_Setup log --oneline`, then pick the last snapshot from before the update. Each one shows the Hyprland version.
2. `hypr-restore <id>`
3. If Hyprland itself is broken, downgrade the package from cache: `sudo pacman -U /var/cache/pacman/pkg/hyprland-<version>*.pkg.tar.zst`
