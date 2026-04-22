#! /usr/bin/env sh

set -e
set -u


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} pipx
pipx install uv

${HOME}/.local/bin/uv tool install -p 3.13 serena-agent@latest --prerelease=allow


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
