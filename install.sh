#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"
. "${SCRIPT_DIR}/dotfiles/common-functions.sh"


#########################
# DOTFILES INSTALLATION #
#########################
# cd dotfiles
# ./install.sh


####################
# REFRESH FEATURES #
####################
# for each feature in the features directory, run the configure script
for feature in "${SCRIPT_DIR}/features/"*/; do
    cp -f "${SCRIPT_DIR}/dotfiles/common-functions.sh" "${feature}/"
    cp -f "${SCRIPT_DIR}/dotfiles/configure.sh" "${feature}/"
    cp -f "${SCRIPT_DIR}/dotfiles/install.sh" "${feature}/"
done
