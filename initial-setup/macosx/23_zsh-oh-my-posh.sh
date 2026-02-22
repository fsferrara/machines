#! /usr/bin/env bash


##########
# CONFIG #
##########


########
# EXEC #
########
printf '\n\n🍭 Configuring oh-my-posh...\n'

sh -c "$(curl -s https://ohmyposh.dev/install.sh | bash -s)"

oh-my-posh font install meslo
printf '\n\n⚠️ > Configure your terminal/editor to use font: MesloLGM Nerd Font\n'

printf '⚠️ > Source the kickstart when your shell starts! Examples:\n'
printf 'echo -e "\\n#My Shell Configuration\\neval \"\$(oh-my-posh init zsh)\"\\n" >> ~/.zshrc\n'

printf '⚠️ > To use oh-my-posh with oh-my-zsh, make sure that you unset the ZSH_THEME from your .zshrc before loading OMZ\n'

exec zsh


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
