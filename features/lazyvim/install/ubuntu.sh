#! /usr/bin/env sh


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} neovim
${CMD_INSTALL} git
${CMD_INSTALL} fzf
${CMD_INSTALL} ripgrep
${CMD_INSTALL} fd-find
${CMD_INSTALL} lazygit

printf '\n\n😎 Remeber to use a nerd font.\n'


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
