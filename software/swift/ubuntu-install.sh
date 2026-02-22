#! /usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"
CMD_PKG_UPDATE="sudo snap refresh"
CMD_PKG_INSTALL="sudo snap install --classic "


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}
${CMD_PKG_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} swiftlang swiftlang-doc


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
