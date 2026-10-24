#! /usr/bin/env bash

set -euo pipefail

##########
# CONFIG #
##########
folder_path() {
    echo "$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
}
CURRENT_DIR=$(folder_path)
CLONE_DIR="${CURRENT_DIR}/github/ronniedroid"


#########
# CLONE #
#########
printf '\n\n🛸 Cloning...\n'
rm -rf "$CLONE_DIR"
mkdir -p "$CLONE_DIR"
cd "$CLONE_DIR" || exit
git clone https://github.com/ronniedroid/getnf.git


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
cd getnf || exit
./install.sh
cd "$CURRENT_DIR" || exit
rm -rf "$CLONE_DIR" # Cleaning up
"${HOME}/.local/bin/getnf" -i JetBrainsMono


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
