#! /usr/bin/env sh

set -e
set -u


########
# KEYS #
########
printf '\n\n🔑 Importing GPG keys...\n'

curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
\curl -sSL https://get.rvm.io | bash -s stable


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
