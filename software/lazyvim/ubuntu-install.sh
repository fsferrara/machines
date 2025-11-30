#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"
CMD_PACK_INSTALL="sudo snap install --classic "


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";
${CMD_PACK_INSTALL} nvim
${CMD_INSTALL} git
${CMD_INSTALL} fzf
${CMD_INSTALL} ripgrep
${CMD_INSTALL} fd-find
${CMD_INSTALL} lazygit

echo -e "\n\n😎 Remeber to use a nerd font.\n";


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
