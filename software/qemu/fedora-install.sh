#! /usr/bin/env bash

set -e
set -u


##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="sudo dnf install --assumeyes "


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing qemu...\n";

# Install QEMU
${CMD_INSTALL} qemu-kvm qemu-img virt-manager libvirt python3-libvirt libguestfs-tools virt-install

# Install QEMU related packages
${CMD_INSTALL} bridge-utils git wget p7zip p7zip-plugins make dmg2img tesseract genisoimage vim net-tools screen quickemu

# Install quickemu
${CMD_INSTALL} quickemu
echo -e "\n\n(!) Optionally, install quick gui: https://github.com/quickemu-project/quickgui/releases\n";

########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
