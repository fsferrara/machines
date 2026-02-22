#!/usr/bin/env bash


##########
# CONFIG #
##########


########
# EXEC #
########
printf '\n\n🍭 Configuring ohmyzsh...\n'
sudo dnf install --assumeyes wget curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
