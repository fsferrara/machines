#! /usr/bin/env bash

set -e
set -u


##########
# CONFIG #
##########
CMD_APPLY="rsync -av"


#########
# APPLY #
#########
echo -e "\n\n🔌 Configuring...\n";
${CMD_APPLY} config/ ~
zsh --version
sudo chsh -s /usr/bin/zsh $USER


########
# DONE #
########
echo -e "Reboot your machine before proceeding";
echo -e "\n\n✅ Done!\n";
exit 0;
