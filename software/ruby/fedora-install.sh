#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="sudo dnf install --assumeyes "


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing system ruby...\n";
${CMD_INSTALL} ruby rubygems ruby-bundled-gems ruby-devel
gem install bundler

echo -e "\n\n🚀 Installing rbenv...\n";
${CMD_INSTALL} rbenv


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
