#!/usr/bin/env bash

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

install_java_17() {
  sdk install java 17.0.4.1-tem
  sdk use java 17.0.4.1-tem
}

install_java_11() {
  sdk install java 11.0.11.hs-adpt
  sdk use java 11.0.11.hs-adpt
}

install_java_8() {
	sdk install java 8.0.292.hs-adpt
	sdk use java 8.0.292.hs-adpt
}

install_java() {
   install_java_17
   install_java_11
   #install_java_8
   sdk default java 17.0.4.1-tem
   echo "WARNING: Please restart the shell!!!"
}

install_java
