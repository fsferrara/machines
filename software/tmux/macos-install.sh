#! /usr/bin/env sh


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
${CMD_INSTALL} tmux
#${CMD_INSTALL} awk perl grep gnu-sed


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
