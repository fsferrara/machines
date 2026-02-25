#! /usr/bin/env sh

set -e
set -u


zsh --version
sudo chsh -s /usr/bin/zsh "$USER"
printf 'Reboot your machine before proceeding\n'


exit 0
