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
${CMD_INSTALL} lazygit
${CMD_INSTALL} fzf
${CMD_INSTALL} ripgrep
${CMD_INSTALL} fd

echo -e "\n\n😎 Remeber to use a nerd font.\n";

########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
