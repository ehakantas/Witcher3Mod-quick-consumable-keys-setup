<# : ---- Windows batch part: starts the PowerShell part below ----
@echo off
setlocal
powershell -NoProfile -Command "iex (${%~f0} | Out-String)"
echo.
pause
exit /b
#>
# =====================================================================
#  Quick Consumable Keys - Key Setup
#  The Witcher 3: Wild Hunt (Remastered, PC)
#
#  What this does:
#   - Edits ONE file: Documents\The Witcher 3\input.settings
#   - Adds (or removes) these 4 lines in 7 sections:
#       IK_F1=(Action=ModCB_UseSlot1) ... IK_F4=(Action=ModCB_UseSlot4)
#   - Makes a backup copy next to the file before any change.
#   - Changes nothing if the lines are already there.
#  What this does NOT do:
#   - No internet, no admin rights, no other files, no game files.
# =====================================================================

$ErrorActionPreference = 'Stop'

$Keys = @(
    'IK_F1=(Action=ModCB_UseSlot1)',
    'IK_F2=(Action=ModCB_UseSlot2)',
    'IK_F3=(Action=ModCB_UseSlot3)',
    'IK_F4=(Action=ModCB_UseSlot4)'
)
$Sections = @('Exploration', 'Combat', 'Horse', 'Swimming', 'JumpClimb', 'Boat', 'BoatPassenger')

# Allow testing on another file: set QCK_INPUT_SETTINGS to a path.
if ($env:QCK_INPUT_SETTINGS) {
    $File = $env:QCK_INPUT_SETTINGS
} else {
    $File = Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'The Witcher 3\input.settings'
}

Write-Host ''
Write-Host '  Quick Consumable Keys - Key Setup'
Write-Host '  ---------------------------------'
Write-Host "  File: $File"
Write-Host ''

if (-not (Test-Path -LiteralPath $File)) {
    Write-Host '  input.settings was not found.'
    Write-Host '  Start The Witcher 3 once (to the main menu), close it, then run this again.'
    return
}

if (Get-Process -Name 'witcher3' -ErrorAction SilentlyContinue) {
    Write-Host '  The Witcher 3 is running. Please close the game first, then run this again.'
    Write-Host '  (The game rewrites this file when it closes.)'
    return
}

Write-Host '  [1] Add F1-F4 keys      (install, or repair after "Reset to defaults")'
Write-Host '  [2] Remove F1-F4 keys   (uninstall)'
Write-Host '  [Q] Quit without changes'
Write-Host ''
$choice = (Read-Host '  Choose 1, 2 or Q').Trim().ToUpper()
if ($choice -ne '1' -and $choice -ne '2') {
    Write-Host '  No changes made.'
    return
}
$adding = ($choice -eq '1')

# --- read the file, keep its encoding and line endings ---------------
$bytes = [IO.File]::ReadAllBytes($File)
if ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE) {
    $encoding = New-Object Text.UnicodeEncoding($false, $true)
} elseif ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    $encoding = New-Object Text.UTF8Encoding($true)
} else {
    $encoding = New-Object Text.UTF8Encoding($false)
}
$text = [IO.File]::ReadAllText($File, $encoding)
if ($text.Contains("`r`n")) { $nl = "`r`n" } else { $nl = "`n" }
$lines = $text -split "`r?`n"

# --- build the new content -------------------------------------------
$out     = New-Object System.Collections.Generic.List[string]
$buffer  = New-Object System.Collections.Generic.List[string]
$current = ''
$done    = @{}
$state   = @{ changes = 0 }

function Close-Section {
    if ($adding -and ($Sections -contains $current) -and -not $done.ContainsKey($current)) {
        $done[$current] = $true
        # insert after the last non-empty line of the section
        $at = $buffer.Count
        while ($at -gt 0 -and $buffer[$at - 1].Trim() -eq '') { $at-- }
        $missing = @($Keys | Where-Object { $buffer -notcontains $_ })
        if ($missing.Count -gt 0) {
            $buffer.InsertRange($at, [string[]]$missing)
            $state.changes += $missing.Count
        }
    }
    $out.AddRange($buffer)
    $buffer.Clear()
}

foreach ($line in $lines) {
    $t = $line.Trim()
    if ($t.StartsWith('[') -and $t.EndsWith(']')) {
        Close-Section
        $current = $t.Substring(1, $t.Length - 2)
        $out.Add($line)
        continue
    }
    if (-not $adding -and ($Keys -contains $t)) {
        $state.changes++
        continue
    }
    $buffer.Add($line)
}
Close-Section

if ($adding) {
    $notFound = @($Sections | Where-Object { -not $done.ContainsKey($_) })
    if ($notFound.Count -gt 0) {
        Write-Host ("  Note: section(s) not found, skipped: " + ($notFound -join ', '))
    }
}

if ($state.changes -eq 0) {
    Write-Host '  Nothing to change - the file is already up to date.'
    return
}

# --- backup, then save -----------------------------------------------
$backup = $File + '.qck-backup-' + (Get-Date -Format 'yyyyMMdd-HHmmss')
Copy-Item -LiteralPath $File -Destination $backup
[IO.File]::WriteAllText($File, ($out -join $nl), $encoding)

if ($adding) {
    Write-Host "  Done. Added $($state.changes) line(s)."
} else {
    Write-Host "  Done. Removed $($state.changes) line(s)."
}
Write-Host "  Backup: $backup"
Write-Host '  You can start the game now.'
