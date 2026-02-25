#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"
. "${SCRIPT_DIR}/../common-functions.sh"


#########
# INPUT #
#########
configure_parameters "$@"


#########
# CLEAN #
#########
# required
rm -rf ${DESTINATION}/.config/nvim

# optional but recommended
rm -rf ${DESTINATION}/.local/share/nvim
rm -rf ${DESTINATION}/.local/state/nvim
rm -rf ${DESTINATION}/.cache/nvim


#########
# APPLY #
#########
configure_apply "${SCRIPT_DIR}/config/" "${DESTINATION}"


#########################
# SPECIFIC INSTRUCTIONS #
#########################



#########
# APPLY #
#########
printf '\n\n🔌 Configuring...\n'
${CMD_APPLY} config/ ~


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;




