#!/usr/bin/env bash
set -e
set -u

LOG_TAG=${0}
echo -e "[${LOG_TAG}] executing...";

pkgs=(awscli)

INSTALL="sudo apt-get install -y"
for pkg in "${pkgs[@]}"
do
    $INSTALL $pkg
done

echo -e "[${LOG_TAG}] completed ;)";
exit 0;
