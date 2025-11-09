#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";


${CMD_INSTALL} build-essential
${CMD_INSTALL} module-assistant
${CMD_INSTALL} git
${CMD_INSTALL} vim
${CMD_INSTALL} colordiff
${CMD_INSTALL} rsync
${CMD_INSTALL} tmux
${CMD_INSTALL} tree
${CMD_INSTALL} curl
${CMD_INSTALL} unzip
${CMD_INSTALL} tar
${CMD_INSTALL} mc
${CMD_INSTALL} wget
${CMD_INSTALL} ssh
${CMD_INSTALL} links
${CMD_INSTALL} patchutils
${CMD_INSTALL} sshfs
${CMD_INSTALL} curlftpfs
${CMD_INSTALL} xsel
${CMD_INSTALL} jq
${CMD_INSTALL} watch
${CMD_INSTALL} htop
${CMD_INSTALL} coreutils
${CMD_INSTALL} netcat
${CMD_INSTALL} nmap
${CMD_INSTALL} sshuttle
${CMD_INSTALL} yamllint
${CMD_INSTALL} procps
${CMD_INSTALL} zip
${CMD_INSTALL} unzip
${CMD_INSTALL} net-tools


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
