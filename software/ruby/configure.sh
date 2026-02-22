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

printf '\n\n🚀 Configuring rbenv...\n'
rbenv init


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
