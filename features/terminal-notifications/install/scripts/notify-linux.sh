#!/bin/bash
# Terminal Notifications for Linux (Ubuntu/Debian/Fedora/Arch)
# Uses notify-send for visual notifications and paplay for sounds
#
# Dependencies:
#   Ubuntu/Debian: sudo apt install libnotify-bin pulseaudio-utils
#   Fedora: sudo dnf install libnotify pulseaudio-utils
#   Arch: sudo pacman -S libnotify pulseaudio
#
# Usage: ./notify-linux.sh "Your message" [sound_type]
# Sound types: input, complete, default, none
#
# Source: https://startupbros.com/terminal-notifications/

MESSAGE="${1:-Terminal notification}"
SOUND_TYPE="${2:-default}"

# Check if notify-send is available
if ! command -v notify-send &>/dev/null; then
    echo "Error: notify-send not found. Install libnotify-bin (Ubuntu/Debian) or libnotify (Fedora/Arch)"
    exit 1
fi

# Detect project context from git
TITLE=""
if git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
    REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -n "$REPO_ROOT" ]; then
        TITLE=$(basename "$REPO_ROOT")
    fi
fi

# Fallback title
if [ -z "$TITLE" ]; then
    TITLE="Terminal"
fi

# Map sound types to freedesktop sound theme
# These are standard sounds available on most Linux desktops
case "$SOUND_TYPE" in
    input)
        SOUND="/usr/share/sounds/freedesktop/stereo/dialog-warning.oga"
        URGENCY="normal"
        ;;
    complete)
        SOUND="/usr/share/sounds/freedesktop/stereo/complete.oga"
        URGENCY="normal"
        ;;
    default)
        SOUND="/usr/share/sounds/freedesktop/stereo/message.oga"
        URGENCY="low"
        ;;
    none)
        SOUND=""
        URGENCY="low"
        ;;
    *)
        SOUND="/usr/share/sounds/freedesktop/stereo/message.oga"
        URGENCY="low"
        ;;
esac

# Send visual notification
notify-send --urgency="$URGENCY" --app-name="Terminal" "$TITLE" "$MESSAGE"

# Play sound if specified and paplay is available
if [ -n "$SOUND" ] && [ -f "$SOUND" ]; then
    if command -v paplay &>/dev/null; then
        paplay "$SOUND" &
    elif command -v aplay &>/dev/null; then
        # Fallback to aplay for systems without PulseAudio
        aplay -q "$SOUND" &
    fi
fi

exit 0
