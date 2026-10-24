#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"


#####################
# CORE INSTALLATION #
#####################
cd "${SCRIPT_DIR}/core"
./install.sh


####################
# REFRESH FEATURES #
####################
printf '\n\n🟢 Refreshing features...\n'
cd "${SCRIPT_DIR}"
for feature in "${SCRIPT_DIR}/features/"*/; do
    cp -f "${SCRIPT_DIR}/core/configure.sh" "${feature}/"
    cp -f "${SCRIPT_DIR}/core/install.sh" "${feature}/"
done


########
# DONE #
########
cd "${INITIAL_DIR}"
printf '\n\n✅ Done!\n'
exit 0;
