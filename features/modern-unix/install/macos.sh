#! /usr/bin/env sh

set -eu

for formula in tldr tlrc; do
    if [ -d "$(brew --prefix)/var/homebrew/linked/$formula" ]; then
        printf 'modern-unix: unlink the conflicting %s formula before installing tealdeer: brew unlink %s\n' "$formula" "$formula" >&2
        exit 1
    fi
done

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
${CMD_INSTALL} duf
${CMD_INSTALL} fd
${CMD_INSTALL} ripgrep
${CMD_INSTALL} fzf
${CMD_INSTALL} jq
${CMD_INSTALL} sd
${CMD_INSTALL} tealdeer
${CMD_INSTALL} gping
${CMD_INSTALL} httpie
${CMD_INSTALL} doggo
${CMD_INSTALL} lazygit
${CMD_INSTALL} hunk
${CMD_INSTALL} eza
${CMD_INSTALL} zoxide
${CMD_INSTALL} btop
${CMD_INSTALL} fastfetch
${CMD_INSTALL} dua-cli

if ! fzf --bash >/dev/null || ! fzf --zsh >/dev/null; then
    printf 'modern-unix: installed fzf must support --bash and --zsh (version >= 0.48).\n' >&2
    exit 1
fi


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
