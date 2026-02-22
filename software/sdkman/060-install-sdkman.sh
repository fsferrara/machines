#!/usr/bin/env bash

LOG_TAG=${0}
echo -e "[${LOG_TAG}] executing...";

pkgs=(zip unzip)

INSTALL="sudo apt-get install -y"
for pkg in "${pkgs[@]}"
do
    $INSTALL $pkg
done

curl -s "https://get.sdkman.io" | bash
. "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version


echo -e "[${LOG_TAG}] completed ;)";
exit 0;
