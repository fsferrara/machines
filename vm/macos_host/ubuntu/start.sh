#! /usr/bin/env bash

set -e
set -u


#############
# BOOTSTRAP #
#############
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
INITIAL_DIR="$(pwd)"


#############
# ARGUMENTS #
#############
qemu_args=(
  # Uses the macOS Hypervisor
  -accel hvf
  # RAM size
  -m 16G
  # CPU cores
  -smp 4
  # Uses the host CPU model
  -cpu host
  # Machine type
  -M virt
  # UEFI firmware for ARM64
  -bios /opt/homebrew/share/qemu/edk2-aarch64-code.fd
  # Disk image
  -drive if=virtio,format=qcow2,file=disk.qcow2
  # Slot 1 - network card
  -device virtio-net-pci,netdev=net0,addr=0x1
  # Slot 2 - Virtio GPU
  -device virtio-gpu-pci,addr=0x2
  # Slot 3 - USB card
  -device qemu-xhci,addr=0x3
  # Slot 4 - Audio
  -audiodev coreaudio,id=audio0
  -device intel-hda,addr=0x4
  -device hda-output,audiodev=audio0
  # Display settings
  -display cocoa,show-cursor=off
  # USB keyboard and mouse
  -device usb-kbd
  # USB tablet for better mouse handling
  -device usb-tablet
  # Network with SSH port forwarding (Host 2222 -> Guest 22)
  -netdev user,id=net0,hostfwd=tcp::2222-:22
  # Shared Folder
  -virtfs local,path=../../share,mount_tag=share,security_model=none,id=share,readonly=off
  # Installation ISO
  -cdrom ubuntu-24.04.4-live-server-arm64.iso
)

################
# INSTRUCTIONS #
################
printf "\nGENERAL INSTRUCTIONS\n"
cat ${SCRIPT_DIR}/README.md
printf "\nSHARED FOLDER INSTRUCTIONS\n"
cat ${SCRIPT_DIR}/../../share/README.md
printf "\nSTARTING THE VM\n"


############
# START VM #
############
qemu-system-aarch64 "${qemu_args[@]}"
