#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="brew update"
CMD_INSTALL="brew install"


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";
${CMD_INSTALL} tmux
#${CMD_INSTALL} awk perl grep gnu-sed


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
