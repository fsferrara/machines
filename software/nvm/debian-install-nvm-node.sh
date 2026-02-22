#!/usr/bin/env bash
set -e
set -u

LOG_TAG=${0}
echo -e "[${LOG_TAG}] executing...";

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install 14.18.1

echo -e "[${LOG_TAG}] completed ;)";
exit 0;
