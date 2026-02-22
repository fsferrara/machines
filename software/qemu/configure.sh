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
printf '\n\n🔌 Configuring...\n'
${CMD_APPLY} config/ ~

printf '\n\n🖥️ Remember to override the default env variables if needed...\n'
./config/bin/qemu-common_config

########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;




