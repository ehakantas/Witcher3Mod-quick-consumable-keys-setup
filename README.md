# Quick Consumable Keys – Key Setup

A tiny helper for the **Quick Consumable Keys** mod (The Witcher 3: Wild Hunt – Remastered, PC).
It turns on the mod's **F1–F4** keys with one double-click.

> **Why is this needed?** Steam Workshop mods can't add new key bindings by themselves.
> The game reads keys from a text file, `input.settings`, so 4 short lines have to be added there.
> This helper adds them for you. You can also do it by hand – see [Manual setup](#manual-setup).

## How to use

1. **Close The Witcher 3.**
2. Download **`QCK-KeySetup.bat`** (green **Code** button → *Download ZIP*, or open the file → *Download raw file*).
3. Double-click it, press **1**, then Enter.
4. Start the game.

Run it again any time you use **Options → Key Bindings → Reset to defaults** (that reset removes mod keys – the mod will remind you in-game).

## What it does – exactly

- Opens **one** file: `Documents\The Witcher 3\input.settings` (a plain text file with your key bindings).
- **Makes a backup first**, next to it: `input.settings.qck-backup-<date-time>`.
- Adds these 4 lines at the end of 7 sections (`[Exploration]`, `[Combat]`, `[Horse]`, `[Swimming]`, `[JumpClimb]`, `[Boat]`, `[BoatPassenger]`):
  ```
  IK_F1=(Action=ModCB_UseSlot1)
  IK_F2=(Action=ModCB_UseSlot2)
  IK_F3=(Action=ModCB_UseSlot3)
  IK_F4=(Action=ModCB_UseSlot4)
  ```
- Skips lines that are already there – running it twice is safe.
- Does nothing if the game is running.

## What it does NOT do

- ❌ No internet access, no downloads
- ❌ No admin rights needed
- ❌ Doesn't touch game files, saves, other mods or any other file
- ❌ Doesn't change your existing key bindings – it only adds lines

**Check it yourself:** right-click `QCK-KeySetup.bat` → *Edit* (or open with Notepad). It's ~150 lines of plain, commented PowerShell.

## Undo

- Run it again and press **2** – removes exactly those lines, or
- Rename the backup file back to `input.settings`.

## Windows warning?

Windows may show *"Windows protected your PC"* for downloaded scripts.
Click **More info → Run anyway** – or use [Manual setup](#manual-setup) instead.

## Manual setup

Open `Documents\The Witcher 3\input.settings` with Notepad (game closed) and paste the 4 lines below
at the end of each of the 7 sections listed. (`[Exploration]`, `[Combat]`, `[Horse]`, `[Swimming]`, `[JumpClimb]`, `[Boat]`, `[BoatPassenger]`):

  ```
  IK_F1=(Action=ModCB_UseSlot1)
  IK_F2=(Action=ModCB_UseSlot2)
  IK_F3=(Action=ModCB_UseSlot3)
  IK_F4=(Action=ModCB_UseSlot4)
  ```
---
