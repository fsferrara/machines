#!/usr/bin/env bash
set -e
set -u
set -o pipefail

ssh user@"${GUEST_IP}" 'mkdir ~/.ssh'

scp ${MACHINES}/configuration/ssh/id_rsa user@${GUEST_IP}:~/.ssh/
scp ${MACHINES}/configuration/ssh/id_rsa.pub user@${GUEST_IP}:~/.ssh/

ssh user@"${GUEST_IP}" 'cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys'

ssh user@"${GUEST_IP}" 'chmod 0400 ~/.ssh/id_rsa*; chmod 640 .ssh/authorized_keys; chmod 700 .ssh'
