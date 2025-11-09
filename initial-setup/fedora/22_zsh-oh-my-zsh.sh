#!/usr/bin/env bash


##########
# CONFIG #
##########


########
# EXEC #
########
echo -e "\n\n🍭 Configuring ohmyzsh...\n";
sudo dnf install --assumeyes wget curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
