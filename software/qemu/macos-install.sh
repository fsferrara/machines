#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="brew update"
CMD_INSTALL="brew install"


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";

# ${CMD_INSTALL} --cask utm
${CMD_INSTALL} qemu libvirt virt-manager

${CMD_INSTALL} git wget p7zip make dmg2img tesseract vim screen cpu_features

# Virtualization utilities
# ${CMD_INSTALL} --cask macfuse #after this install osxfuse/sshfs


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
