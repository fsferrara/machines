#! /usr/bin/env sh

set -e
set -u


####################
# BOOTSTRAP COMMON #
####################
MACHINE_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)


###################
# INSTALL SUPPORT #
###################
run_install() {
  # check if the OS is osx,debian or ubuntu and call the corresponding install script with a case statement
  OS=$(uname -s)
  case "$OS" in
      Darwin)
          printf '\n\n🍎 Detected macOS...\n'
          if [ -f "${SCRIPT_DIR}/install/macosx.sh" ]; then
              ${SCRIPT_DIR}/install/macosx.sh
          else
              printf '\n\n⚠️  No macOS install script found, skipping...\n'
          fi
          ;;
      Linux)
          if [ -f /etc/os-release ]; then
              . /etc/os-release
              case "$ID" in
                  ubuntu)
                      printf '\n\n🐧 Detected Ubuntu...\n'
                      if [ -f "${SCRIPT_DIR}/install/ubuntu.sh" ]; then
                          ${SCRIPT_DIR}/install/ubuntu.sh
                      else
                          printf '\n\n⚠️  No Ubuntu install script found, skipping...\n'
                      fi
                      ;;
                  debian)
                      printf '\n\n🐧 Detected Debian...\n'
                      if [ -f "${SCRIPT_DIR}/install/debian.sh" ]; then
                          ${SCRIPT_DIR}/install/debian.sh
                      else
                          printf '\n\n⚠️  No Debian install script found, skipping...\n'
                      fi
                      ;;
              esac
          fi
          ;;
  esac
}


#####################
# CONFIGURE SUPPORT #
#####################
configure_help() {
    printf '\nUsage: %s [destination]\n\n' "$0"
    printf 'destination: The folder where the configuration will be applied. Default is the home directory.\n'
    exit 0;
}

configure_parameters() {
    if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
        configure_help
    else
        DESTINATION=${1:-${HOME}}
    fi
}

configure_apply() {
    CMD_APPLY="rsync -av"

    local source="$1"
    local destination="$2"

    printf '\n\n🔌 Applying configuration from %s to %s...\n' "${source}" "${destination}"
    ${CMD_APPLY} "${source}" "${destination}"
}
