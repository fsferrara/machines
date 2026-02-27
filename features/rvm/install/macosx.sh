#! /usr/bin/env sh

set -e
set -u


##########
# CONFIG #
##########
CMD_UPDATE="brew update"
CMD_INSTALL="brew install"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Requirements...\n'
${CMD_INSTALL} gnupg


########
# KEYS #
########
printf '\n\n🔑 Importing GPG keys...\n'

curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

printf '\n\n🚀 Installing...\n'
curl -sSL https://get.rvm.io | bash -s stable


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
