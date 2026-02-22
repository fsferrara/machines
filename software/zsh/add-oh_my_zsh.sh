#! /usr/bin/env sh


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"
CMD_APPLY="rsync -av"


##########
# UPDATE #
##########
printf '\n\n🛸 Updading...\n'
${CMD_UPDATE}


###########
# INSTALL #
###########
printf '\n\n🚀 Installing...\n'
${CMD_INSTALL} git wget


#########
# APPLY #
#########
printf '\n\n🔌 Configuring...\n'
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh


########
# DONE #
########
printf 'Reboot your machine before proceeding\n'
printf '\n\n✅ Done!\n'
exit 0;
