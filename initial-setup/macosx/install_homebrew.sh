#! /usr/bin/env bash

install_homebrew(){
	cd
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	sudo chown -R $(whoami): /usr/local/share/zsh # Fixes an issue with brew install on Mac OS Big Sur
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_homebrew
