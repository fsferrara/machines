#! /usr/bin/env bash
set -e
set -u

LOG_TAG=${0}
printf '[%s] executing...\n' "$LOG_TAG"

pkgs=(awscli)

INSTALL="sudo apt-get install -y"
for pkg in "${pkgs[@]}"
do
    $INSTALL $pkg
done

printf '[%s] completed ;)\n' "$LOG_TAG"
exit 0;
