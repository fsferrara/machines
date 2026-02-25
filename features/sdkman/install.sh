#! /usr/bin/env sh

set -e
set -u



pkgs=(zip unzip)

INSTALL="sudo apt-get install -y"
for pkg in "${pkgs[@]}"
do
    $INSTALL $pkg
done


install_sdk_man(){
	curl -s "https://get.sdkman.io" | bash
	# shellcheck source=/dev/null
	. "$HOME/.sdkman/bin/sdkman-init.sh"
}

install_sdk_man
