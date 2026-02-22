#! /usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo snap refresh"
CMD_INSTALL="sudo snap install --classic "


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} alacritty


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
