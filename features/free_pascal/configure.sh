#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"


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


##############
# PARAMETERS #
##############
configure_parameters "$@"


#################
# PRE CONFIGURE #
#################
if [ -f "${SCRIPT_DIR}/pre-configure.sh" ]; then
  printf '\n\n🟡 Pre Configure...\n'
  "${SCRIPT_DIR}/pre-configure.sh"
fi


#############
# CONFIGURE #
#############
configure_apply "${SCRIPT_DIR}/config/" "${DESTINATION}"


##################
# POST CONFIGURE #
##################
if [ -f "${SCRIPT_DIR}/post-configure.sh" ]; then
  printf '\n\n🟠 Post Configure...\n'
  "${SCRIPT_DIR}/post-configure.sh"
fi


########
# DONE #
########
printf '\n\n✅ Done!\n'
