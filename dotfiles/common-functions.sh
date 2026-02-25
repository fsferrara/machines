#! /usr/bin/env sh

set -e
set -u


####################
# BOOTSTRAP COMMON #
####################
MACHINE_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)


#####################
# CONFIGURE SUPPORT #
#####################
configure_help() {
    printf '\nUsage: %s [destination]\n\n' "$0"
    printf 'destination: The folder where the configuration will be applied. Default is the home directory.\n'
    exit 0;
}

configure_parameters() {
    if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
        configure_help
    else
        DESTINATION=${1:-${HOME}}
    fi
}

configure_apply() {
    CMD_APPLY="rsync -av"

    local source="$1"
    local destination="$2"

    printf '\n\n🔌 Applying configuration from %s to %s...\n' "${source}" "${destination}"
    ${CMD_APPLY} "${source}" "${destination}"
}
