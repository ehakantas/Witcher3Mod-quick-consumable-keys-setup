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

## Running the setup – step by step

**1. Download the file**

- Open [QCK-KeySetup.bat](https://github.com/ehakantas/Witcher3Mod-quick-consumable-keys-setup/blob/main/QCK-KeySetup.bat) and click the **Download raw file** icon (↓) at the top right of the code box, **or**
  download everything as a ZIP: [main.zip](https://github.com/ehakantas/Witcher3Mod-quick-consumable-keys-setup/archive/refs/heads/main.zip) and unzip it.

**2. Close The Witcher 3** (exit the game).

**3. Double-click `QCK-KeySetup.bat`.**
If Windows shows *"Windows protected your PC"*, click **More info → Run anyway** (see [Windows warning?](#windows-warning)).

**4. A black window opens.** It shows the file it will edit and a small menu. Type **1** and press **Enter**.

**5. Done.** The window tells you how many lines were added and where the backup is. Press any key to close it.

**6. Start the game.** Open the Inventory, hover a potion, decoction or food and press **F1–F4** to assign it. Close the inventory and press the same key to use it.

**Other messages you may see**

| Message | What it means |
|---|---|
| `Nothing to change - the file is already up to date.` | The keys are already set up. Nothing was changed. |
| `The Witcher 3 is running. Please close the game first...` | Exit the game, then run the file again. |
| `input.settings was not found.` | Start the game once (to the main menu), exit, then run the file again. |
| `No changes made.` | You chose **Q** (or another key). Nothing was changed. |

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
