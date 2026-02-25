#! /usr/bin/env sh

set -e
set -u


# required
rm -rf ${DESTINATION}/.config/nvim

# optional but recommended
rm -rf ${DESTINATION}/.local/share/nvim
rm -rf ${DESTINATION}/.local/state/nvim
rm -rf ${DESTINATION}/.cache/nvim


exit 0
