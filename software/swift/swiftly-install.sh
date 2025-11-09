#!/usr/bin/env bash


##########
# CONFIG #
##########


##########
# UPDATE #
##########


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";
curl -O https://download.swift.org/swiftly/linux/swiftly-$(uname -m).tar.gz && \
tar zxf swiftly-$(uname -m).tar.gz && \
./swiftly init --quiet-shell-followup && \
. "${SWIFTLY_HOME_DIR:-$HOME/.local/share/swiftly}/env.sh" && \
hash -r

echo -e "\n\n😎 Remember to place the `.swift-version` file in your project directory!\n";

########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
