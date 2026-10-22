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
printf '\n\n🛸 Updading...\n'
#${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
#${CMD_INSTALL} herdr

INSTALLER=$(mktemp)
trap 'rm -f "$INSTALLER"' 0
trap 'exit 1' HUP INT TERM
curl -fsSL https://herdr.dev/install.sh -o "$INSTALLER"
sh "$INSTALLER"


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
