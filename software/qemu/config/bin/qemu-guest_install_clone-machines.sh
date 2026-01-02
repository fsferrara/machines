#!/usr/bin/env bash
set -e
set -u
set -o pipefail

ssh user@"${GUEST_IP}" 'ssh-keyscan github.com >> ~/.ssh/known_hosts'
ssh user@"${GUEST_IP}" 'mkdir -p ~/github/fsferrara'
ssh user@"${GUEST_IP}" 'cd ~/github/fsferrara && git clone git@github.com:fsferrara/machines.git'
