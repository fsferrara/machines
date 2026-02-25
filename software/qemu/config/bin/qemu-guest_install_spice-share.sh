#! /usr/bin/env bash

set -e
set -u


LOG_TAG=${0}
printf '[%s] executing...\n' "$LOG_TAG"

sudo apt-get update

pkgs=(davfs2)

INSTALL="sudo apt-get install -y"
for pkg in "${pkgs[@]}"
do
    ${INSTALL} ${pkg}
done

sudo usermod -a -G davfs2 ${USER}

printf '[%s] completed ;)\n' "$LOG_TAG"
exit 0;
