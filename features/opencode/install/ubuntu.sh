#! /usr/bin/env sh

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
# printf '\n\n🛸 Updading...\n'
# ${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
# ${CMD_INSTALL} ollama
curl -fsSL https://opencode.ai/install | bash


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
