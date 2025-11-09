#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="brew update"
CMD_INSTALL="brew install"


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";
${CMD_INSTALL} neovim
${CMD_INSTALL} git
${CMD_INSTALL} make
${CMD_INSTALL} fzf
${CMD_INSTALL} python3
${CMD_INSTALL} nodejs npm
${CMD_INSTALL} rust


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
