#! /bin/sh

# use `0` to have FN functionality instead of the media keys
# use `1` to switch back to media keys
FN_MODE=0

# apply configuration
# bug: this scpriopt only append options. Remember to clean the old option before adding the new one.
echo options hid_apple fnmode=${FN_MODE} | sudo tee -a /etc/modprobe.d/hid_apple.conf

# copy the configuration into the initramfs boot file.
sudo update-initramfs -u -k all

printf "Please reboot...\n"

#Activating now on-the-fly
echo 0 | pkexec tee /sys/module/hid_apple/parameters/fnmode
