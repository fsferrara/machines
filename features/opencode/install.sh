#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"


###################
# INSTALL SUPPORT #
###################
run_install() {
  if [ -f "${SCRIPT_DIR}/install/install.sh" ]; then
      printf '\n\n🚀 Running generic install script...\n'
      ${SCRIPT_DIR}/install/install.sh
  else
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
                  esac
              fi
              ;;
      esac
  fi
}


##########
#  USER  #
##########
# if _REMOTE_USER is not set don't switch user
if [ -n "${_REMOTE_USER:-}" ]; then
  if [ "$(id -un)" != "${_REMOTE_USER}" ]; then
    exec su - "${_REMOTE_USER}" -c "_REMOTE_USER= _REMOTE_USER_HOME=\"${_REMOTE_USER_HOME:-}\" sh \"${SCRIPT_DIR}/install.sh\""
  fi
fi


###########
# INSTALL #
###########
run_install


##################
# CALL CONFIGURE #
##################
# if _REMOTE_USER_HOME is not set, use current user home
DESTINATION="${_REMOTE_USER_HOME:-$HOME}"
printf '\n\n🟢 Calling configure with target home: %s...\n' "${DESTINATION}"
${SCRIPT_DIR}/configure.sh "${DESTINATION}"
