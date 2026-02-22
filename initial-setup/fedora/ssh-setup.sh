#! /usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="sudo dnf install --assumeyes "


########
# EXEC #
########
$CMD_UPDATE

printf '\n\n🖥️ Installing the SSH Server...\n'
$CMD_INSTALL openssh-server

sudo systemctl enable sshd
sudo systemctl start sshd
sudo systemctl status sshd
sudo ss -lt


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;





