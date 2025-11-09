#!/usr/bin/env bash


##########
# CONFIG #
##########


########
# EXEC #
########
echo -e "\n\n🍭 Configuring oh-my-posh...\n";

sh -c "$(curl -s https://ohmyposh.dev/install.sh | bash -s)"

oh-my-posh font install meslo
echo -e "\n\n⚠️ > Configure your terminal/editor to use font: MesloLGM Nerd Font";

echo -e "⚠️ > Source the kickstart when your shell starts! Examples:"
echo -e 'echo -e "\\n#My Shell Configuration\\neval \"\$(oh-my-posh init zsh)\"\\n" >> ~/.zshrc'

echo -e "⚠️ > To use oh-my-posh with oh-my-zsh, make sure that you unset the ZSH_THEME from your .zshrc before loading OMZ"

exec zsh


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
