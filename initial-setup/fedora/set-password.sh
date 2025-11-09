#!/usr/bin/env bash


##########
# CONFIG #
##########
USERNAME=$(whoami)


########
# EXEC #
########

echo -e "\n\n🔐 root password change...\n";
sudo passwd

echo -e "\n\n🔐 password change for ${USERNAME}...\n";
sudo passwd ${USERNAME}


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;





