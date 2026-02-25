#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"
. "${SCRIPT_DIR}/common-functions.sh"

echo "MACHINE_DIR: ${MACHINE_DIR}"
echo "SCRIPT_DIR: ${SCRIPT_DIR}"
echo "INITIAL_DIR: ${INITIAL_DIR}"



#########################
# DOTFILES INSTALLATION #
#########################
# cd dotfiles
# ./install.sh
