#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} nodejs
${CMD_INSTALL} npm
${CMD_INSTALL} yarnpkg


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
