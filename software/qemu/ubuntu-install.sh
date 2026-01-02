#! /usr/bin/env bash

set -e
set -u
set -o pipefail


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"
CMD_PKG_UPDATE="sudo snap refresh"
CMD_PKG_INSTALL="sudo snap install --classic "


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}
${CMD_PKG_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing qemu...\n";

# qemu-kvm: the main backend that provides KVM hardware acceleration through QEMU.
# qemu-img: a command-line tool for creating, converting, and modifying disk images used by QEMU.
${CMD_INSTALL} qemu-system qemu-kvm

# libvirt-daemon-system: the libvirtd daemon that manages KVM and QEMU instances. It is the main interface for KVM.
# libvirt-clients: contains client tools (such as virsh) to interact with libvirtd.
${CMD_INSTALL} libvirt-daemon-system libvirt-clients libguestfs-tools

# utilities for configuring bridge networking and other.
${CMD_INSTALL} bridge-utils uml-utilities

# virtinst: command-line tools for quickly creating virtual machines.
${CMD_INSTALL} virtinst

# virt-manager: a very intuitive and powerful graphical interface for managing KVM virtual machines. Strongly recommended for most users.
${CMD_INSTALL} virt-manager

# Install QEMU related packages
${CMD_INSTALL} git wget p7zip p7zip-full make dmg2img genisoimage tesseract-ocr tesseract-ocr-eng vim net-tools screen cpu-checker


# Install quickemu
${CMD_INSTALL} quickemu
echo -e "\n\n(!) Optionally, install quick gui: https://github.com/quickemu-project/quickgui/releases\n";

########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
