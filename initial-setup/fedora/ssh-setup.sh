#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="sudo dnf install --assumeyes "


########
# EXEC #
########
$CMD_UPDATE

echo -e "\n\n🖥️ Installing the SSH Server...\n";
$CMD_INSTALL openssh-server

sudo systemctl enable sshd
sudo systemctl start sshd
sudo systemctl status sshd
sudo ss -lt


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;





