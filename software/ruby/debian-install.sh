#!/usr/bin/env bash


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
echo -e "\n\n🚀 Installing system ruby...\n";
${CMD_INSTALL} ruby ruby-rubygems ruby-bundler ruby-dev
gem install bundler

echo -e "\n\n🚀 Installing rbenv...\n";
${CMD_INSTALL} rbenv


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
