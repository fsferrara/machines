#!/usr/bin/env bash


##########
# CONFIG #
##########


########
# EXEC #
########
printf '\n\n🛵 Installing ZSH...\n'
sudo dnf install --assumeyes zsh

printf '\n\n♻️ Changing shell...\n'
chsh -s $(which zsh)


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
