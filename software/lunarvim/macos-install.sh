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
${CMD_INSTALL} mpv


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
