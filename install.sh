#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INITIAL_DIR="$(pwd)"
source "${SCRIPT_DIR}/common-functions.sh"
printf "${MACHINE_DIR} OK"


#########################
# DOTFILES INSTALLATION #
#########################
# cd dotfiles
# ./install.sh
