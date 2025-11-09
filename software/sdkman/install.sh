#!/usr/bin/env bash

install_sdk_man(){
	curl -s "https://get.sdkman.io" | bash
	source "$HOME/.sdkman/bin/sdkman-init.sh"
}

install_sdk_man
