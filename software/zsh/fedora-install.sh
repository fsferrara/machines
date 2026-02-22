#!/usr/bin/env bash


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
${CMD_INSTALL} zsh


########
# DONE #
########
printf 'Reboot your machine before proceeding\n'
printf '\n\n✅ Done!\n'
exit 0;
