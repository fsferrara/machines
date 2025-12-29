#! /usr/bin/env bash

set -e
set -u
set -o pipefail


##########
# CONFIG #
##########
CMD_APPLY="rsync -av"


#########
# APPLY #
#########
echo -e "\n\n🔌 Configuring...\n";
${CMD_APPLY} config/ ~


##############
# POST APPLY #
##############
# Permission
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/*
chmod 0400 ~/.ssh/id*
ssh-add
ssh-add -l


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
