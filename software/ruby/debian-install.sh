#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing system ruby...\n'
${CMD_INSTALL} ruby ruby-rubygems ruby-bundler ruby-dev
gem install bundler

printf '\n\n🚀 Installing rbenv...\n'
${CMD_INSTALL} rbenv


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
