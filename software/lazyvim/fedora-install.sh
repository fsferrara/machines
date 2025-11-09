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
${CMD_INSTALL} git
${CMD_INSTALL} fzf
${CMD_INSTALL} ripgrep
${CMD_INSTALL} fd-find

sudo dnf copr enable dejan/lazygit
${CMD_INSTALL} lazygit
sudo dnf copr disable dejan/lazygit

echo -e "\n\n😎 Remeber to use a nerd font.\n";


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
