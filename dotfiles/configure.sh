#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
INITIAL_DIR="$(pwd)"
source "${SCRIPT_DIR}/../common-functions.sh"
printf "${MACHINE_DIR} OK"


########
# HELP #
########
help() {
    printf '\nUsage: %s [destination]\n\n' "$0"
    printf 'destination: The folder where the configuration will be applied. Default is the home directory.\n'
    exit 0;
}

if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
    help
fi


#########
# INPUT #
#########
DESTINATION=${1:-${HOME}}


#########
# APPLY #
#########
printf '\n\n🔌 Configuring...\n'
apply_config "${SCRIPT_DIR}/config/" "${DESTINATION}"

printf '(!) If needed, source the kickstart when your shell starts! Examples:\n'
printf 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.bashrc\n'
printf 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.zshrc\n'


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
