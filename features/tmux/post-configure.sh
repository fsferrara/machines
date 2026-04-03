#! /usr/bin/env sh

set -e
set -u


SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)

# tic
tic "${SCRIPT_DIR}/config/bin/terminfo/screen-256color.terminfo"


exit 0
