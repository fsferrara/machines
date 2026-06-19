#!/bin/bash
# Terminal Notifications for macOS (Zero Dependencies)
# Uses native AppleScript - works on any Mac without installing anything
#
# Usage: ./notify-mac.sh "Your message" [sound_type]
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

# Map sound types to macOS system sounds
# Available sounds: Basso, Blow, Bottle, Frog, Funk, Glass, Hero,
# Morse, Ping, Pop, Purr, Sosumi, Submarine, Tink
case "$SOUND_TYPE" in
    input)    SOUND="Basso" ;;     # Deep tone - attention needed
    complete) SOUND="Glass" ;;     # Pleasant - task done
    default)  SOUND="Pop" ;;       # Neutral default
    none)     SOUND="" ;;          # Silent
    *)        SOUND="Pop" ;;
esac

# Build AppleScript command
if [ -n "$SOUND" ]; then
    osascript -e "display notification \"$MESSAGE\" with title \"$SUBTITLE\" sound name \"$SOUND\""
else
    osascript -e "display notification \"$MESSAGE\" with title \"$SUBTITLE\""
fi

exit 0
