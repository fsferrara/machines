#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"
. "${SCRIPT_DIR}/common-functions.sh"


##############
# PARAMETERS #
##############
configure_parameters "$@"


#################
# PRE CONFIGURE #
#################
if [ -f "${SCRIPT_DIR}/pre-configure.sh" ]; then
  printf '\n\n🟡 Pre Configure...\n'
  "${SCRIPT_DIR}/pre-configure.sh"
fi


#############
# CONFIGURE #
#############
configure_apply "${SCRIPT_DIR}/config/" "${DESTINATION}"


##################
# POST CONFIGURE #
##################
if [ -f "${SCRIPT_DIR}/post-configure.sh" ]; then
  printf '\n\n🟠 Post Configure...\n'
  "${SCRIPT_DIR}/post-configure.sh"
fi


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
