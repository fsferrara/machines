#!/usr/bin/env bash
set -e
set -u

LOG_TAG=${0}
echo -e "[${LOG_TAG}] executing...";

cd ~/downloads

echo -e "[${LOG_TAG}] removing existing version, if any...";
sudo dpkg -r docker-ce-cli

echo -e "[${LOG_TAG}] downloading...";
wget https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/docker-ce-cli_23.0.5-1~ubuntu.22.04~jammy_amd64.deb
echo -e "[${LOG_TAG}] installing...";
sudo dpkg -i docker-ce-cli_23.0.5-1~ubuntu.22.04~jammy_amd64.deb

echo -e "[${LOG_TAG}] remember to export the following environment variable:"
echo -e "export DOCKER_HOST=tcp://${HOST_IP}"

cd -

echo -e "[${LOG_TAG}] completed ;)";
exit 0;
