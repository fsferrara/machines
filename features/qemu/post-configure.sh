#! /usr/bin/env sh

set -e
set -u


printf '\n\n🖥️ Remember to override the default env variables if needed...\n'
./config/bin/qemu-common_config


exit 0
