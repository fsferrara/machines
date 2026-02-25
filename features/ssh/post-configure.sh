#! /usr/bin/env sh

set -e
set -u


# Permission
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/*
chmod 0400 ~/.ssh/id*
ssh-add
ssh-add -l


exit 0
