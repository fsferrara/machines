#!/usr/bin/env bash


##########
# CONFIG #
##########


########
# EXEC #
########
echo -e "\n\n🛵 Installing ZSH...\n";
sudo dnf install --assumeyes zsh

echo -e "\n\n♻️ Changing shell...\n";
chsh -s $(which zsh)


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
