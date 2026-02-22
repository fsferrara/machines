#! /usr/bin/env bash

export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && . "$HOME/.sdkman/bin/sdkman-init.sh"

install_maven_3_6_2() {
	sdk install maven 3.6.2
	sdk use maven 3.6.2
}

install_maven() {
   install_maven_3_6_2
   sdk default maven 3.6.2
   echo "WARNING: Please restart the shell!!!"
}

install_maven
