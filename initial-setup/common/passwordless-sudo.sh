#!/usr/bin/env bash
set -e
set -u
set -o pipefail

echo -e "ALL\tALL = (ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/passwordless
