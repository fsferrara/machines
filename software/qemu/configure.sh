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

echo -e "\n\n🖥️ Remember to override the default env variables if needed...\n";
./config/bin/qemu-common_config

########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;




