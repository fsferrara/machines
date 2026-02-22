#! /usr/bin/env sh

##########
# CONFIG #
##########
CMD_UPDATE="brew update"
CMD_INSTALL="brew install"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'

${CMD_INSTALL} fastfetch
${CMD_INSTALL} cowsay
${CMD_INSTALL} fortunes


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
