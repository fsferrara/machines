#!/usr/bin/env bash


########
# KEYS #
########
echo -e "\n\n🔑 Importing GPG keys...\n";

curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";
\curl -sSL https://get.rvm.io | bash -s stable


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
