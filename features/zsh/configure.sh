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
zsh --version
sudo chsh -s /usr/bin/zsh "$USER"


########
# DONE #
########
printf 'Reboot your machine before proceeding\n'
printf '\n\n✅ Done!\n'
exit 0;
