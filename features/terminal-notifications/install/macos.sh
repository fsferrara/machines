#! /usr/bin/env sh

set -e
set -u


########
# DEPS #
########
CMD_UPDATE="brew update"
CMD_INSTALL="brew install"

printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}

printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} terminal-notifier


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)


##########
# CONFIG #
##########
SOURCE_SCRIPT_APPLESCRIPT="${SCRIPT_DIR}/scripts/notify-mac.sh"
SOURCE_SCRIPT_TERMINAL_NOTIFIER="${SCRIPT_DIR}/scripts/notify-mac-terminal-notifier.sh"
TARGET_HOME="${_REMOTE_USER_HOME:-$HOME}"
TARGET_BIN_DIR="${TARGET_HOME}/.local/bin"
TARGET_NOTIFY="${TARGET_BIN_DIR}/notify"


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
install -d "${TARGET_BIN_DIR}"

if command -v terminal-notifier >/dev/null 2>&1; then
    printf '\nDetected terminal-notifier, installing terminal-notifier notification command...\n'
    SOURCE_SCRIPT="${SOURCE_SCRIPT_TERMINAL_NOTIFIER}"
else
    printf '\nterminal-notifier not found, installing AppleScript notification command...\n'
    SOURCE_SCRIPT="${SOURCE_SCRIPT_APPLESCRIPT}"
fi

install -m 0755 "${SOURCE_SCRIPT}" "${TARGET_NOTIFY}"
printf '\nInstalled terminal notifications command: %s\n' "${TARGET_NOTIFY}"


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0
