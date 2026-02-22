#! /usr/bin/env sh


##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="echo sudo dnf install --assumeyes "
PAK_INSTALL="echo flatpak install "


########
# EXEC #
########
printf '\n\n🔌 Updating...\n'
${CMD_UPDATE}

printf '\n\n🔌 Development Essentials...\n'
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


printf '\n\n🔌 Collaboration...\n'


printf '\n\n🔌 Personalization...\n'
$CMD_INSTALL dconf-editor gnome-tweaks
$PAK_INSTALL flathub com.mattjakeman.ExtensionManager


printf '\n\n🔌 Virtualization...\n'
$CMD_INSTALL @guest-agents
$CMD_INSTALL @guest-desktop-agents
$CMD_INSTALL spice-vdagent spice-webdavd # to share clipboard and folders with SPICE
$CMD_INSTALL davfs2 # to mount remote shares


printf '\n\n🔌 Networking...\n'
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


printf '\n\n🔌 General Software...\n'
$CMD_INSTALL google-chrome-stable
$CMD_INSTALL keepassxc


printf '\n\n🔌 Command Line...\n'
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
printf '\n\n✅ Done! I did not install anything :-)\n...it is up to you to copy/paste the commands\n'
exit 0;





