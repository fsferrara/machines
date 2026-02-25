#! /usr/bin/env sh

set -e
set -u


## ubuntu - need to add you in the docker group
sudo gpasswd -a "$USER" docker


exit 0
