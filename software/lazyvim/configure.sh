#! /usr/bin/env bash

set -e
set -u
set -o pipefail


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
echo -e "\n\n🔌 Configuring...\n";
${CMD_APPLY} config/ ~


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;




