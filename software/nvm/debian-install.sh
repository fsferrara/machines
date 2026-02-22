#! /usr/bin/env bash
set -e
set -u

LOG_TAG=${0}
printf '[%s] executing...\n' "$LOG_TAG"


git clone https://github.com/nvm-sh/nvm.git ~/.nvm
cd ~/.nvm
git checkout v0.39.3
. ./nvm.sh
cd -
echo "WARNING: Please restart the shell!!!"

printf '[%s] completed ;)\n' "$LOG_TAG"
exit 0;
