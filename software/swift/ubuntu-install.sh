#! /usr/bin/env sh


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"
CMD_PKG_UPDATE="sudo snap refresh"


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
