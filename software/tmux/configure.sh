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

# tic
tic config/bin/terminfo/screen-256color.terminfo

########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
