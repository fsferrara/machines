#! /usr/bin/env sh

set -e
set -u


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="echo sudo apt install -y "
CMD_INSTALL_PACK="echo sudo snap install --classic "


########
# EXEC #
########
printf '\n\n🔌 Updating...\n'
${CMD_UPDATE}

printf '\n\n🔌 Development Essentials...\n'
${CMD_INSTALL} build-essential
${CMD_INSTALL} module-assistant
${CMD_INSTALL} autoconf automake cmake
${CMD_INSTALL} coreutils
${CMD_INSTALL} git
${CMD_INSTALL} patchutils
${CMD_INSTALL} jq
${CMD_INSTALL} yamllint


printf '\n\n🔌 Collaboration...\n'
${CMD_INSTALL_PACK} zoom-client
${CMD_INSTALL_PACK} slack
${CMD_INSTALL_PACK} discord
${CMD_INSTALL} hexchat
${CMD_INSTALL_PACK} telegram-desktop



printf '\n\n🔌 Personalization...\n'


printf '\n\n🔌 Virtualization...\n'


printf '\n\n🔌 Utility...\n'
${CMD_INSTALL_PACK} sublime-text
${CMD_INSTALL_PACK} sublime-merge
${CMD_INSTALL_PACK} rpi-imager
${CMD_INSTALL_PACK} swach
${CMD_INSTALL_PACK} remmina
${CMD_INSTALL} 7zip
${CMD_INSTALL} filezilla
${CMD_INSTALL} android-file-transfer


printf '\n\n🔌 Networking...\n'
${CMD_INSTALL_PACK} zaproxy
${CMD_INSTALL_PACK} freelens
${CMD_INSTALL} links
${CMD_INSTALL} nmap
${CMD_INSTALL} netcat-traditional
${CMD_INSTALL} sshuttle
${CMD_INSTALL} net-tools
${CMD_INSTALL} ssh
${CMD_INSTALL} wireshark


printf '\n\n🔌 General Software...\n'
${CMD_INSTALL_PACK} bitwarden
${CMD_INSTALL_PACK} alacritty
${CMD_INSTALL_PACK} code
${CMD_INSTALL_PACK} gitkraken
${CMD_INSTALL_PACK} insomnia
${CMD_INSTALL_PACK} postman
${CMD_INSTALL_PACK} gimp
${CMD_INSTALL_PACK} inkscape
${CMD_INSTALL_PACK} chromium
${CMD_INSTALL_PACK} brave
${CMD_INSTALL_PACK} vlc
${CMD_INSTALL} calibre
${CMD_INSTALL_PACK} dropbox
${CMD_INSTALL_PACK} obsidian
${CMD_INSTALL_PACK} dbeaver-ce


printf '\n\n🔌 Command Line...\n'
${CMD_INSTALL} ncal
${CMD_INSTALL} colordiff
${CMD_INSTALL} rsync
${CMD_INSTALL} tmux
${CMD_INSTALL} tree
${CMD_INSTALL} curl
${CMD_INSTALL} unzip
${CMD_INSTALL} tar
${CMD_INSTALL} mc
${CMD_INSTALL} wget
${CMD_INSTALL} sshfs
${CMD_INSTALL} curlftpfs
${CMD_INSTALL} xsel
${CMD_INSTALL} watch
${CMD_INSTALL} htop
${CMD_INSTALL} procps
${CMD_INSTALL} zip
${CMD_INSTALL} unzip
${CMD_INSTALL} grep
${CMD_INSTALL} watch
${CMD_INSTALL} sed
${CMD_INSTALL} bat
${CMD_INSTALL} ffmpeg
${CMD_INSTALL} yt-dlp


########
# DONE #
########
printf '\n\n✅ Done! I did not install anything :-)\n...it is up to you to copy/paste the commands\n'
exit 0;
