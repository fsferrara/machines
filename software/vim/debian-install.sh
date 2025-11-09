#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";
${CMD_INSTALL} vim
${CMD_INSTALL} fzf
${CMD_INSTALL} silversearcher-ag
${CMD_INSTALL} ripgrep
${CMD_INSTALL} bat


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
