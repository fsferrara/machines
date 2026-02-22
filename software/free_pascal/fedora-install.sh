#! /usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="sudo dnf install"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} fpc fpc-ide
${CMD_INSTALL} lazarus


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
