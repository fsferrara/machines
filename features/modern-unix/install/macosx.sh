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
${CMD_INSTALL} glow
${CMD_INSTALL} bat
${CMD_INSTALL} lsd
${CMD_INSTALL} delta
${CMD_INSTALL} dust
${CMD_INSTALL} duf
${CMD_INSTALL} broot
${CMD_INSTALL} fd
${CMD_INSTALL} ripgrep
${CMD_INSTALL} fzf
${CMD_INSTALL} mcfly
${CMD_INSTALL} jq
${CMD_INSTALL} sd
${CMD_INSTALL} cheat
${CMD_INSTALL} tldr
${CMD_INSTALL} glances
${CMD_INSTALL} gping
${CMD_INSTALL} procs
${CMD_INSTALL} httpie
${CMD_INSTALL} doggo
${CMD_INSTALL} lazygit


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
