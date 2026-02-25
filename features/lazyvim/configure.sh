#! /usr/bin/env sh

set -e
set -u


##########
# CONFIG #
##########
CMD_APPLY="rsync -av"


#########
# CLEAN #
#########
# required
rm -rf ~/.config/nvim

# optional but recommended
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim


#########
# APPLY #
#########
printf '\n\n🔌 Configuring...\n'
${CMD_APPLY} config/ ~


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;




