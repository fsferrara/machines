#! /usr/bin/env bash

set -e
set -u


LOG_TAG=${0}
printf '[%s] executing...\n' "$LOG_TAG"

pkgs=(zip unzip)

INSTALL="sudo apt-get install -y"
for pkg in "${pkgs[@]}"
do
    $INSTALL $pkg
done

curl -s "https://get.sdkman.io" | bash
. "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version


printf '[%s] completed ;)\n' "$LOG_TAG"
exit 0;
