#! /usr/bin/env bash


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
printf '\n\n🚀 Installing system ruby...\n'
${CMD_INSTALL} ruby rubygems ruby-bundled-gems ruby-devel
gem install bundler

printf '\n\n🚀 Installing rbenv...\n'
${CMD_INSTALL} rbenv


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
