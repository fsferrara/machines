#! /usr/bin/env sh

set -e
set -u


####################
# BOOTSTRAP COMMON #
####################
MACHINE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

printf '${MACHINE_DIR}: %s\n' "${MACHINE_DIR}"
printf '${INITIAL_DIR}: %s\n' "${INITIAL_DIR}"
printf '${SCRIPT_DIR}: %s\n' "${SCRIPT_DIR}"


################
# APPLY CONFIG #
################
# Usage: apply_config "source_folder/" "destination_folder/"
apply_config() {
    CMD_APPLY="rsync -av"

    local source="$1"
    local destination="$2"

    printf '\n\n🔌 Applying configuration from %s to %s...\n' "${source}" "${destination}"
    ${CMD_APPLY} "${source}" "${destination}"
}
