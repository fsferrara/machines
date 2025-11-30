#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo snap refresh"
CMD_INSTALL="sudo snap install --classic "


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";
${CMD_INSTALL} alacritty


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
