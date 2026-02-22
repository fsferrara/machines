#! /usr/bin/env sh

##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="sudo dnf install --assumeyes "


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
