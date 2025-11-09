#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="echo sudo dnf install --assumeyes "
PAK_INSTALL="echo flatpak install "


########
# EXEC #
########
echo -e "\n\n🔌 Development Essentials...\n";
$CMD_INSTALL @development-tools
$CMD_INSTALL @development-libs
$CMD_INSTALL @c-development
$CMD_INSTALL @editors
$CMD_INSTALL git
$CMD_INSTALL glib
$CMD_INSTALL automake
$CMD_INSTALL yamllint

$CMD_INSTALL node
$CMD_INSTALL yarn

$CMD_INSTALL @engineering-and-scientific


echo -e "\n\n🔌 Collaboration...\n";


echo -e "\n\n🔌 Personalization...\n";
$CMD_INSTALL dconf-editor gnome-tweaks
$PAK_INSTALL flathub com.mattjakeman.ExtensionManager


echo -e "\n\n🔌 Virtualization...\n";
$CMD_INSTALL @guest-agents
$CMD_INSTALL @guest-desktop-agents
$CMD_INSTALL spice-vdagent spice-webdavd # to share clipboard and folders with SPICE
$CMD_INSTALL davfs2 # to mount remote shares


echo -e "\n\n🔌 Networking...\n";
$CMD_INSTALL @text-internet
$CMD_INSTALL net-tools
$CMD_INSTALL iproute
$CMD_INSTALL nmap
$CMD_INSTALL sshuttle
$CMD_INSTALL awscli
$CMD_INSTALL netcat
$CMD_INSTALL wget
$CMD_INSTALL curl
$CMD_INSTALL netcat


echo -e "\n\n🔌 General Software...\n";
$CMD_INSTALL google-chrome-stable
$CMD_INSTALL keepassxc


echo -e "\n\n🔌 Command Line...\n";
$CMD_INSTALL jq
$CMD_INSTALL mc
$CMD_INSTALL colordiff
$CMD_INSTALL htop
$CMD_INSTALL tree
$CMD_INSTALL tmux
$CMD_INSTALL grep
$CMD_INSTALL watch
$CMD_INSTALL coreutils
$CMD_INSTALL sed
$CMD_INSTALL bat


########
# DONE #
########
echo -e "\n\n✅ Done! I didn't installed anything :-)\n...it is up to you to copy/paste the commands\n";
exit 0;





