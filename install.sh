#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"
. "${SCRIPT_DIR}/common-functions.sh"


#########################
# DOTFILES INSTALLATION #
#########################
cp -f "${MACHINE_DIR}/common-functions.sh" "${MACHINE_DIR}/dotfiles/"

# cd dotfiles
# ./install.sh


####################
# REFRESH FEATURES #
####################
# for each feature in the features directory, run the configure script
for feature in "${MACHINE_DIR}/features/"*/; do
    cp -f "${MACHINE_DIR}/dotfiles/common-functions.sh" "${feature}/"
    cp -f "${MACHINE_DIR}/dotfiles/configure.sh" "${feature}/"
done
