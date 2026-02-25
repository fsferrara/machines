#! /usr/bin/env sh

set -e
set -u


##########
# CONFIG #
##########
CMD_INSTALL="sudo apt install -y"
sudo apt update


################
# COMMAND LINE #
################
${CMD_INSTALL} jq
${CMD_INSTALL} mc
${CMD_INSTALL} colordiff
${CMD_INSTALL} htop
${CMD_INSTALL} git
${CMD_INSTALL} wget
${CMD_INSTALL} tree
${CMD_INSTALL} tmux
${CMD_INSTALL} grep
${CMD_INSTALL} watch
${CMD_INSTALL} coreutils
${CMD_INSTALL} sed
${CMD_INSTALL} automake
${CMD_INSTALL} build-essential
${CMD_INSTALL} cmake
${CMD_INSTALL} curl
${CMD_INSTALL} unzip


########
# DONE #
########
printf '\n\n✅ Done!\n'
