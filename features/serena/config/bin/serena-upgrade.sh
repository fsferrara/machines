#! /usr/bin/env bash

set -e
set -u


###########
# UPGRADE #
###########
printf '\n\n🚀 Upgrading...\n'
uv tool upgrade serena-agent --prerelease=allow


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
