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
${CMD_INSTALL} neovim
${CMD_INSTALL} git
${CMD_INSTALL} lazygit
${CMD_INSTALL} fzf
${CMD_INSTALL} ripgrep
${CMD_INSTALL} fd

printf '\n\n😎 Remeber to use a nerd font.\n'

########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
