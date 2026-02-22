#!/usr/bin/env bash
set -e
set -u

printf 'ALL\tALL = (ALL) NOPASSWD: ALL\n' | sudo tee /etc/sudoers.d/passwordless
