- Enable 
- Install NVIDIA Linux Graphics Driver
- Enable and reboot

## NVIDIA kernel module missing. Falling back to nouveau

Is secure boot enabled? mokutil --sb-state will answer that.

If secure boot is enabled then the nvidia modules cannot be loaded unless you

    disable secure boot in the bios setup menu
    or
    sign the modules so they can be loaded with secure boot enabled.

It is late enough that I cannot remain to walk you thru this, but signing the modules is relatively simple

    follow the steps in the file /usr/share/doc/akmods/README.secureboot to generate the key and enroll it in bios. (the commands require the use of sudo)
    remove the unsigned modules and rebuild them with
    sudo akmods --force --rebuild
    reboot


## Check which driver you are using

- lspci -n -n -k | grep -A 2 -e VGA -e 3D
- modinfo -F version nvidia
