#! /usr/bin/env bash

set -x
set -u
set -o pipefail

# Locate OVMF firmware on the host and prepare a local writable VARS file
# Common locations: /usr/share/OVMF/OVMF_CODE.fd or OVMF_CODE_4M.fd
if [ -f /usr/share/OVMF/OVMF_CODE_4M.fd ]; then
  OVMF_CODE=/usr/share/OVMF/OVMF_CODE_4M.fd
  OVMF_VARS=/usr/share/OVMF/OVMF_VARS_4M.fd
elif [ -f /usr/share/OVMF/OVMF_CODE.fd ]; then
  OVMF_CODE=/usr/share/OVMF/OVMF_CODE.fd
  OVMF_VARS=/usr/share/OVMF/OVMF_VARS.fd
else
  echo "OVMF firmware not found in /usr/share/OVMF. Install with: sudo apt install ovmf" >&2
  exit 1
fi

# Copy the VARS file locally so QEMU can write UEFI variable state
LOCAL_VARS=./OVMF_VARS.fd
if [ ! -f "$LOCAL_VARS" ]; then
  if [ -f "$OVMF_VARS" ]; then
    cp "$OVMF_VARS" "$LOCAL_VARS"
  else
    # If a vendor VARS doesn't exist, create an empty 64k file as a fallback
    dd if=/dev/zero of="$LOCAL_VARS" bs=1k count=64 >/dev/null 2>&1 || true
  fi
fi

# QEMU Arguments
qemu_args=(
  # Uses the macOS Hypervisor
  -accel kvm
  # RAM size
  -m 16G
  # CPU cores
  -smp 4
  # Uses the host CPU model
  -cpu host
  # Machine type (x86_64)
  -M q35
  # UEFI firmware for X86_64 (CODE readonly, VARS writable)
  -drive if=pflash,format=raw,readonly=on,file=${OVMF_CODE}
  -drive if=pflash,format=raw,file=${LOCAL_VARS}
  # Disk image
  -drive if=virtio,format=qcow2,file=ubuntu-server.qcow2
  # Slot 1 - Virtio GPU
  -device pcie-root-port,id=rp1,slot=0x10,bus=pcie.0,addr=0x10
  -device virtio-gpu-pci,bus=rp1,addr=0x0
  # Slot 2 - network card
  -device pcie-root-port,id=rp2,slot=0x11,bus=pcie.0,addr=0x11
  -device virtio-net-pci,netdev=net0,bus=rp2,addr=0x0
  # Slot 3 - USB card
  -device pcie-root-port,id=rp3,slot=0x12,bus=pcie.0,addr=0x12
  -device qemu-xhci,bus=rp3,addr=0x0
  # Display settings
  -display default
  # USB keyboard and mouse
  -device usb-kbd
  # USB tablet for better mouse handling
  -device usb-tablet
  # Network with SSH port forwarding (Host 2222 -> Guest 22)
  -netdev user,id=net0,hostfwd=tcp::2222-:22
  # Shared Folder
  -virtfs local,path=../../share,mount_tag=share,security_model=mapped-file,id=share,readonly=off
  -virtfs local,path=../../../shell,mount_tag=shell,security_model=mapped-file,id=shell,readonly=off
  -virtfs local,path=../../../software,mount_tag=software,security_model=mapped-file,id=software,readonly=off
  # Installation ISO
  -cdrom ubuntu-24.04.3-live-server-amd64.iso
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
qemu-system-x86_64 "${qemu_args[@]}"
