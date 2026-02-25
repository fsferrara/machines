#! /usr/bin/env sh

set -e
set -u


export SDKMAN_DIR="$HOME/.sdkman"
# shellcheck source=/dev/null
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && . "$HOME/.sdkman/bin/sdkman-init.sh"

install_gradle_6_3() {
	sdk install gradle 6.3
	sdk use gradle 6.3
}

install_gradle() {
   install_gradle_6_3
   sdk default gradle 6.3
   echo "WARNING: Please restart the shell!!!"
}

install_gradle
