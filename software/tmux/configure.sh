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

# tic
tic config/bin/terminfo/screen-256color.terminfo

########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
