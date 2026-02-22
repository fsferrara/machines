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
printf '\n\n✅ Done!\n'
exit 0;
