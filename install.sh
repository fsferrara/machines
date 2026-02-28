#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"


#########################
# DOTFILES INSTALLATION #
#########################
cd "${SCRIPT_DIR}/dotfiles"
./install.sh


####################
# REFRESH FEATURES #
####################
printf '\n\n🟢 Refreshing features...\n'
cd "${SCRIPT_DIR}"
for feature in "${SCRIPT_DIR}/features/"*/; do
    rm -f "${feature}/common-functions.sh"
    cp -f "${SCRIPT_DIR}/dotfiles/configure.sh" "${feature}/"
    cp -f "${SCRIPT_DIR}/dotfiles/install.sh" "${feature}/"
done


########
# DONE #
########
cd "${INITIAL_DIR}"
printf '\n\n✅ Done!\n'
exit 0;
