#!/usr/bin/env bash

install_casks_for_tools_and_tech() {

  # [CASK] Development Essentials
  brew install --cask sublime-text
  brew install --cask visual-studio-code
  brew install --cask vscodium
  brew install --cask jetbrains-toolbox
  #brew install --cask intellij-idea # replaced by jetbrains-toolbox
  #brew install --cask intellij-idea-ce # replaced by jetbrains-toolbox
  brew install --cask lm-studio
  brew install --cask docker
  brew install --cask lens
  brew install --cask insomnia
  #brew install --cask postman #stick with insomnia
  #brew install --cask diffmerge
  brew install --cask fork
  brew install --cask adobe-acrobat-reader
  brew install --cask google-chrome
  #brew install --cask chromium
  #brew install --cask firefox
  #brew install --cask microsoft-edge
  #brew install --cask opera
  #brew install --cask alacritty

  # [CASK] Collaboration
  #brew install --cask zoom #use self-service
  brew install --cask slack

  # [CASK] My MacOS Personalization
  #brew install --cask appcleaner #replaced by a shell scrpt
  #brew install --cask disk-expert #use this only if need to free up space
  brew install --cask jordanbaird-ice
  #brew install --cask clipy
  brew install --cask maccy # clipboard manager
  #brew install --cask rectangle #replaced by macosx sequoia
  #brew install --cask spaceid # build your version from the fork
  #brew install --cask karabiner-elements #replaced by macosx keyboard settings
  brew install --cask alt-tab
  # brew install --cask background-music # allow quicktime to record screen and audio
  printf '[NOT a Cask] Please install Sleep Control Center from the app store\n'

  # [CASK] Networking
  #brew install --cask microsoft-remote-desktop #use self service
  brew install --cask vnc-viewer
  brew install --cask cyberduck
  #brew install --cask wireshark
  brew install --cask charles
  #brew install --cask burp-suite

  # [CASK] General Software
  #brew install --cask git-credential-manager
  #brew install --cask libreoffice
  #brew install --cask calibre
  brew install --cask gimp
  brew install --cask vlc
  #brew install --cask dropbox
  #brew install --cask foxitreader
  brew install --cask obsidian
  #brew install --cask macpass
  brew install --cask bitwarden
  brew install bitwarden-cli
  brew install --cask macvim

  # [CASK] Personal Utilities
  #brew install --cask sdformatter
  #brew install --cask balenaetcher
  #brew install --cask raspberry-pi-imager
  brew install mac-cleanup-py
  brew install --cask android-file-transfer
  brew install --cask the-unarchiver

  # Command Line
  brew install git # can you use xcode git?
  brew install jq
  brew install wget
  brew install mc
  brew install colordiff
  brew install tree
  brew install tmux
  brew install htop
  brew install grep
  brew install watch
  brew install coreutils
  brew install gnu-sed
  brew install netcat
  brew install nmap
  brew install sshuttle
  brew install node
  brew install yarn
  brew install yamllint
  brew install glib
  brew install automake
  brew install bat

  # AWS #run when needed
  brew install awscli

  # GitHub CLI
  brew install gh

  # Personal Command Line Tools #run when needed
  brew install ffmpeg
  brew install yt-dlp # replaces youtube-dl

  . ~/.zshrc
}

install_casks_for_tools_and_tech
