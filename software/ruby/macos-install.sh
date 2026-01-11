#! /usr/bin/env bash

set -e
set -u
set -o pipefail


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
${CMD_INSTALL} ruby


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
