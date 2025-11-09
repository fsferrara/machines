#!/usr/bin/env bash

LOG_TAG=${0}
echo -e "[${LOG_TAG}] executing...";

sudo apt-get update

pkgs=(davfs2)

INSTALL="sudo apt-get install -y"
for pkg in "${pkgs[@]}"
do
    ${INSTALL} ${pkg}
done

sudo usermod -a -G davfs2 ${USER}

echo -e "[${LOG_TAG}] completed ;)";
exit 0;
