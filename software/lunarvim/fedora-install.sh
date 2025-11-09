#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="sudo dnf install"


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
${CMD_INSTALL} neovim-ale
${CMD_INSTALL} git
${CMD_INSTALL} make
${CMD_INSTALL} fzf
${CMD_INSTALL} python3 python3-pip
${CMD_INSTALL} nodejs npm
${CMD_INSTALL} cargo


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
