#!/bin/bash
# Terminal Notifications for Windows (via WSL2)
# Sends Windows 11 toast notifications from WSL2 using PowerShell
#
# No additional dependencies required - uses built-in Windows APIs
#
# Usage: ./notify-windows.sh "Your message" [sound_type]
# Sound types: input, complete, default, none
#
# Source: https://startupbros.com/terminal-notifications/

MESSAGE="${1:-Terminal notification}"
SOUND_TYPE="${2:-default}"

# Detect project context from git
SUBTITLE=""
if git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
    REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -n "$REPO_ROOT" ]; then
        SUBTITLE=$(basename "$REPO_ROOT")
    fi
fi

# Fallback subtitle
if [ -z "$SUBTITLE" ]; then
    SUBTITLE="Terminal"
fi

# Escape quotes for PowerShell
MESSAGE_ESCAPED="${MESSAGE//\"/\`\"}"
SUBTITLE_ESCAPED="${SUBTITLE//\"/\`\"}"

# Map sound types to Windows Media files
# Explore more at C:\Windows\Media\
case "$SOUND_TYPE" in
    input)    WAV_FILE="C:\\Windows\\Media\\Windows Exclamation.wav" ;;
    complete) WAV_FILE="C:\\Windows\\Media\\tada.wav" ;;
    default)  WAV_FILE="C:\\Windows\\Media\\Windows Default.wav" ;;
    none)     WAV_FILE="" ;;
    *)        WAV_FILE="C:\\Windows\\Media\\Windows Default.wav" ;;
esac

# Use Windows PowerShell 5.1 for balloon notification + sound
# Run in background but with proper sound handling
/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -NonInteractive -Command "
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Show balloon notification
\$balloon = New-Object System.Windows.Forms.NotifyIcon
\$balloon.Icon = [System.Drawing.SystemIcons]::Information
\$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
\$balloon.BalloonTipTitle = '$SUBTITLE_ESCAPED'
\$balloon.BalloonTipText = '$MESSAGE_ESCAPED'
\$balloon.Visible = \$true
\$balloon.ShowBalloonTip(5000)

# Play sound synchronously
if ('$WAV_FILE' -ne '') {
    \$player = New-Object System.Media.SoundPlayer '$WAV_FILE'
    \$player.PlaySync()
}

# Brief pause then cleanup
Start-Sleep -Milliseconds 500
\$balloon.Dispose()
" 2>/dev/null &

exit 0
