#!/bin/bash
# Terminal Notifications for macOS (using terminal-notifier)
# Richer notifications with actions and app icon support
#
# Requires: brew install terminal-notifier
#
# Usage: ./notify-mac-terminal-notifier.sh "Your message" [sound_type]
# Sound types: input, complete, default, none

MESSAGE="${1:-Terminal notification}"
SOUND_TYPE="${2:-default}"

# Check if terminal-notifier is installed
if ! command -v terminal-notifier &>/dev/null; then
    echo "Error: terminal-notifier not found. Install with: brew install terminal-notifier"
    exit 1
fi

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
case "$SOUND_TYPE" in
    input)    SOUND="Basso" ;;     # Deep tone - attention needed
    complete) SOUND="Glass" ;;     # Pleasant - task done
    default)  SOUND="default" ;;   # System default
    none)     SOUND="" ;;          # Silent
    *)        SOUND="default" ;;
esac

# Build terminal-notifier command
NOTIFY_CMD=(
    terminal-notifier
    -title "$SUBTITLE"
    -message "$MESSAGE"
    -group terminal-notify
)

# Add sound if specified
if [ -n "$SOUND" ]; then
    NOTIFY_CMD+=(-sound "$SOUND")
fi

# Execute
"${NOTIFY_CMD[@]}"

exit 0
