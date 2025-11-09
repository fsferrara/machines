#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"
CMD_APPLY="rsync -av"


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";
${CMD_INSTALL} git wget


#########
# APPLY #
#########
echo -e "\n\n🔌 Configuring...\n";
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh


########
# DONE #
########
echo -e "Reboot your machine before proceeding";
echo -e "\n\n✅ Done!\n";
exit 0;
