#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"
. "${SCRIPT_DIR}/common-functions.sh"


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
TARGET_HOME="${_REMOTE_USER_HOME:-$HOME}"
printf '\n\n🟢 Calling configure with target home: %s...\n' "${TARGET_HOME}"
${SCRIPT_DIR}/configure.sh "${TARGET_HOME}"
