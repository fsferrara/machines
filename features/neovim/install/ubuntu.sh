#! /usr/bin/env sh

set -eu

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

candidate=$(apt-cache policy neovim | sed -n 's/^[[:space:]]*Candidate: //p')
if [ -z "$candidate" ] || [ "$candidate" = "(none)" ] ||
    ! dpkg --compare-versions "$candidate" ge 0.11.2; then
    printf 'Neovim >= 0.11.2 is required; apt candidate: %s. Use Ubuntu 26.04 or newer compatible repositories.\n' "${candidate:-missing}" >&2
    exit 1
fi


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

nvim --headless -u NONE -i NONE \
    '+lua if vim.fn.has("nvim-0.11.2") == 0 or not jit then vim.api.nvim_err_writeln("Neovim >= 0.11.2 with LuaJIT is required"); vim.cmd("cquit") end' +qa

printf '\n\n😎 Remeber to use a nerd font.\n'


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
