#! /usr/bin/env bash

set -e
set -u

# QEMU Arguments
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
  -drive if=virtio,format=qcow2,file=ubuntu-server.qcow2
  # Slot 1 - network card
  -device virtio-net-pci,netdev=net0,addr=0x1
  # Slot 2 - Virtio GPU
  -device virtio-gpu-pci,addr=0x2
  # Slot 3 - USB card
  -device qemu-xhci,addr=0x3
  # Display settings
  -display default
  # USB keyboard and mouse
  -device usb-kbd
  # USB tablet for better mouse handling
  -device usb-tablet
  # Network with SSH port forwarding (Host 2222 -> Guest 22)
  -netdev user,id=net0,hostfwd=tcp::2222-:22
  # Shared Folder
  -virtfs local,path=../../share,mount_tag=share,security_model=none,id=share,readonly=off
  -virtfs local,path=../../../shell,mount_tag=shell,security_model=none,id=shell,readonly=off
  -virtfs local,path=../../../software,mount_tag=software,security_model=none,id=software,readonly=off
  # Installation ISO
  -cdrom ubuntu-24.04.3-live-server-arm64.iso
)

echo ""
echo "-----------------------------------"
echo "VM Setup Instructions"
echo ""
echo "1. To enable passwordless sudo, run the following command:"
echo -e 'echo -e "ALL\tALL = (ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/passwordless'
echo ""
echo "-----------------------------------"

# Start the VM
qemu-system-aarch64 "${qemu_args[@]}"
