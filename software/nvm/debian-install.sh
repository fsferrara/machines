#!/usr/bin/env bash
set -e
set -u

LOG_TAG=${0}
echo -e "[${LOG_TAG}] executing...";


git clone https://github.com/nvm-sh/nvm.git ~/.nvm
cd ~/.nvm
git checkout v0.39.3
. ./nvm.sh
cd -
echo "WARNING: Please restart the shell!!!"

echo -e "[${LOG_TAG}] completed ;)";
exit 0;
