#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)


##########
# CONFIG #
##########
SOURCE_SCRIPT="${SCRIPT_DIR}/scripts/notify-mac.sh"
TARGET_HOME="${_REMOTE_USER_HOME:-$HOME}"
TARGET_BIN_DIR="${TARGET_HOME}/.local/bin"
TARGET_NOTIFY="${TARGET_BIN_DIR}/notify"


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
install -d "${TARGET_BIN_DIR}"
install -m 0755 "${SOURCE_SCRIPT}" "${TARGET_NOTIFY}"
printf '\nInstalled terminal notifications command: %s\n' "${TARGET_NOTIFY}"


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0
