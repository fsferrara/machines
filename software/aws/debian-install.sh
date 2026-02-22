#! /usr/bin/env sh
set -e
set -u

LOG_TAG=${0}
printf '[%s] executing...\n' "$LOG_TAG"

INSTALL="sudo apt-get install -y"
$INSTALL awscli

printf '[%s] completed ;)\n' "$LOG_TAG"
exit 0;
