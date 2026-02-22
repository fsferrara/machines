#! /usr/bin/env sh

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
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing qemu...\n'

# Install QEMU
${CMD_INSTALL} qemu-kvm qemu-img virt-manager libvirt python3-libvirt libguestfs-tools virt-install

# Install QEMU related packages
${CMD_INSTALL} bridge-utils git wget p7zip p7zip-plugins make dmg2img tesseract genisoimage vim net-tools screen quickemu

# Install quickemu
${CMD_INSTALL} quickemu
printf '\n\n(!) Optionally, install quick gui: https://github.com/quickemu-project/quickgui/releases\n'

########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
