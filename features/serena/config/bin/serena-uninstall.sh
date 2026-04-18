#! /usr/bin/env bash

set -e
set -u


#############
# UNINSTALL #
#############
printf '\n\n🚀 Uninstalling...\n'
uv tool uninstall serena-agent


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
