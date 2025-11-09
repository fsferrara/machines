#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_APPLY="rsync -av"


#########
# CLEAN #
#########
sudo usermod -aG kvm $(whoami)
sudo usermod -aG libvirt $(whoami)
sudo usermod -aG input $(whoami)


#########
# APPLY #
#########
echo -e "\n\n🔌 Configuring...\n";
${CMD_APPLY} config/ ~


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;




