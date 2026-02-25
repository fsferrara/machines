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
# APPLY #
#########
configure_apply "${SCRIPT_DIR}/config/" "${DESTINATION}"


#########################
# SPECIFIC INSTRUCTIONS #
#########################


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
