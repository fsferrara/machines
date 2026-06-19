#! /usr/bin/env sh

set -e
set -u


########
# DEPS #
########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"

printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}

printf '\n\n🚀 Dependencies...\n'
${CMD_INSTALL} libnotify-bin pulseaudio-utils


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)


is_wsl() {
    if [ -n "${WSL_DISTRO_NAME:-}" ]; then
        return 0
    fi

    if [ -r /proc/sys/kernel/osrelease ] && grep -qi microsoft /proc/sys/kernel/osrelease; then
        return 0
    fi

    return 1
}


##########
# CONFIG #
##########
SOURCE_SCRIPT_LINUX="${SCRIPT_DIR}/scripts/notify-linux.sh"
SOURCE_SCRIPT_WSL="${SCRIPT_DIR}/scripts/notify-windows.sh"
TARGET_HOME="${_REMOTE_USER_HOME:-$HOME}"
TARGET_BIN_DIR="${TARGET_HOME}/.local/bin"
TARGET_NOTIFY="${TARGET_BIN_DIR}/notify"
CMD_INSTALL="sudo apt install -y"


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'

install -d "${TARGET_BIN_DIR}"

if is_wsl; then
    printf '\nDetected WSL, installing Windows notification bridge...\n'
    install -m 0755 "${SOURCE_SCRIPT_WSL}" "${TARGET_NOTIFY}"
else
    printf '\nDetected Ubuntu, installing notification dependencies...\n'
    ${CMD_INSTALL} libnotify-bin pulseaudio-utils
    install -m 0755 "${SOURCE_SCRIPT_LINUX}" "${TARGET_NOTIFY}"
fi

printf '\nInstalled terminal notifications command: %s\n' "${TARGET_NOTIFY}"


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0
