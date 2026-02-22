#!/usr/bin/env bash
set -e
set -u

##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";

${CMD_INSTALL} fastfetch
${CMD_INSTALL} cowsay
${CMD_INSTALL} fortunes


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
