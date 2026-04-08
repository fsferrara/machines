#! /usr/bin/env sh


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} unzip wget

cd ~/tmp

ARCH=$(uname -m)
wget -O "awscliv2.zip" "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH}.zip"
unzip awscliv2.zip
sudo ./aws/install

cd -

########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;
