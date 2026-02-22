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

## ubuntu - need to add you in the docker group
sudo gpasswd -a $USER docker

########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
