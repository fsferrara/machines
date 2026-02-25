#! /usr/bin/env sh

set -e
set -u


##########
# CONFIG #
##########
CMD_APPLY="rsync -av"


#########
# APPLY #
#########
printf '\n\n🔌 Configuring...\n'
${CMD_APPLY} config/ ~

## ubuntu - need to add you in the docker group
sudo gpasswd -a "$USER" docker

########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
