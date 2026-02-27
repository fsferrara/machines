#! /usr/bin/env sh

set -e
set -u


##########
# CONFIG #
##########
CMD_UPDATE="brew update"
CMD_INSTALL="brew install"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} ruby@3.3

########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
