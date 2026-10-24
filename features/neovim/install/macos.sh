#! /usr/bin/env sh

set -eu

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

nvim --headless -u NONE -i NONE \
    '+lua if vim.fn.has("nvim-0.11.2") == 0 or not jit then vim.api.nvim_err_writeln("Neovim >= 0.11.2 with LuaJIT is required"); vim.cmd("cquit") end' +qa

printf '\n\n😎 Remeber to use a nerd font.\n'

########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
