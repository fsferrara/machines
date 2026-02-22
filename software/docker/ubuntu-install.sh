#!/usr/bin/env bash
set -e
set -u

LOG_TAG=${0}
printf '[%s] executing...\n' "$LOG_TAG"

cd ~/downloads

printf '[%s] removing existing version, if any...\n' "$LOG_TAG"
sudo dpkg -r docker-ce-cli

printf '[%s] downloading...\n' "$LOG_TAG"
wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-ce-cli_23.0.5-1~ubuntu.22.04~jammy_amd64.deb
printf '[%s] installing...\n' "$LOG_TAG"
sudo dpkg -i docker-ce-cli_23.0.5-1~ubuntu.22.04~jammy_amd64.deb

printf '[%s] remember to export the following environment variable:\n' "$LOG_TAG"
printf 'export DOCKER_HOST=tcp://%s\n' "${HOST_IP}"

cd -

printf '[%s] completed ;)\n' "$LOG_TAG"
exit 0;
