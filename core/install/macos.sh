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
${CMD_INSTALL} jq
${CMD_INSTALL} mc
${CMD_INSTALL} colordiff
${CMD_INSTALL} htop
${CMD_INSTALL} git
${CMD_INSTALL} wget
${CMD_INSTALL} tree
${CMD_INSTALL} tmux
${CMD_INSTALL} grep
${CMD_INSTALL} watch
${CMD_INSTALL} coreutils
${CMD_INSTALL} gnu-sed
${CMD_INSTALL} automake
${CMD_INSTALL} gcc
${CMD_INSTALL} cmake
${CMD_INSTALL} curl
${CMD_INSTALL} unzip
${CMD_INSTALL} rsync


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
