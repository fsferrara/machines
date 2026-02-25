#! /usr/bin/env sh

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"
. "${SCRIPT_DIR}/common-functions.sh"


#########
# INPUT #
#########
configure_parameters "$@"

#########
# APPLY #
#########
configure_apply "${SCRIPT_DIR}/config/" "${DESTINATION}"


#########################
# SPECIFIC INSTRUCTIONS #
#########################
printf '(!) If needed, source the kickstart when your shell starts! Examples:\n'
printf 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.bashrc\n'
printf 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.zshrc\n'


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
