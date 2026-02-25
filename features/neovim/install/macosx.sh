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
${CMD_INSTALL} make
${CMD_INSTALL} gcc
${CMD_INSTALL} ripgrep
${CMD_INSTALL} ffind
${CMD_INSTALL} unzip
${CMD_INSTALL} git
${CMD_INSTALL} xclip



# A Nerd Font: optional, provides various icons
# if you have it set vim.g.have_nerd_font in init.lua to true

########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
