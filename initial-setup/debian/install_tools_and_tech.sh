#! /usr/bin/env sh

set -e
set -u


##########
# CONFIG #
##########
CMD_INSTALL="sudo apt install -y"
CMD_INSTALL_PACK="flatpak install -y"


##########
# UTILIY #
##########
${CMD_INSTALL_PACK} com.github.tchx84.Flatseal # used to fix flatpaks permission
${CMD_INSTALL_PACK} org.keepassxc.KeePassXC
${CMD_INSTALL_PACK} com.bitwarden.desktop
${CMD_INSTALL_PACK} com.usebottles.bottles
${CMD_INSTALL_PACK} com.github.finefindus.eyedropper
${CMD_INSTALL_PACK} org.raspberrypi.rpi-imager
${CMD_INSTALL} alacritty
${CMD_INSTALL} 7zip
${CMD_INSTALL} android-file-transfer


#################
# COLLABORATION #
#################
${CMD_INSTALL_PACK} us.zoom.Zoom
${CMD_INSTALL_PACK} com.slack.Slack
${CMD_INSTALL_PACK} com.discordapp.Discord
${CMD_INSTALL_PACK} io.github.Hexchat


###############
# DEVELOPMENT #
###############
${CMD_INSTALL_PACK} org.chromium.Chromium
# editors
${CMD_INSTALL} code
${CMD_INSTALL} vim-gtk3
${CMD_INSTALL_PACK} com.vscodium.codium
${CMD_INSTALL_PACK} com.sublimetext.three
${CMD_INSTALL_PACK} org.exbin.BinEd
# api
${CMD_INSTALL_PACK} com.getpostman.Postman
${CMD_INSTALL_PACK} rest.insomnia.Insomnia
# source
${CMD_INSTALL_PACK} org.gnome.meld
${CMD_INSTALL_PACK} com.axosoft.GitKraken
${CMD_INSTALL_PACK} com.sublimemerge.App
# db
${CMD_INSTALL_PACK} io.dbeaver.DBeaverCommunity


################
# GENERAL APPS #
################
${CMD_INSTALL_PACK} com.google.Chrome
${CMD_INSTALL_PACK} com.opera.Opera
${CMD_INSTALL_PACK} com.brave.Browser
${CMD_INSTALL_PACK} org.videolan.VLC
${CMD_INSTALL_PACK} org.gimp.GIMP
${CMD_INSTALL_PACK} com.adobe.Reader
${CMD_INSTALL_PACK} com.calibre_ebook.calibre
${CMD_INSTALL_PACK} com.dropbox.Client
${CMD_INSTALL_PACK} md.obsidian.Obsidian


##############
# NETWORKING #
##############
${CMD_INSTALL_PACK} org.remmina.Remmina
${CMD_INSTALL_PACK} org.filezillaproject.Filezilla
${CMD_INSTALL_PACK} org.wireshark.Wireshark
${CMD_INSTALL_PACK} org.zaproxy.ZAP
${CMD_INSTALL_PACK} app.freelens.Freelens


################
# COMMAND LINE #
################
${CMD_INSTALL} jq
${CMD_INSTALL} mc
${CMD_INSTALL} colordiff
${CMD_INSTALL} htop
${CMD_INSTALL} netcat
${CMD_INSTALL} nmap
${CMD_INSTALL} sshuttle
${CMD_INSTALL} git
${CMD_INSTALL} wget
${CMD_INSTALL} tree
${CMD_INSTALL} tmux
${CMD_INSTALL} grep
${CMD_INSTALL} watch
${CMD_INSTALL} coreutils
${CMD_INSTALL} sed
${CMD_INSTALL} netcat
${CMD_INSTALL} nmap
${CMD_INSTALL} sshuttle
${CMD_INSTALL} yamllint
${CMD_INSTALL} glib
${CMD_INSTALL} automake
${CMD_INSTALL} bat
${CMD_INSTALL} ffmpeg
${CMD_INSTALL} yt-dlp


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
