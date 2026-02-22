#! /usr/bin/env sh


##########
# CONFIG #
##########
USERNAME=$(whoami)


########
# EXEC #
########

printf '\n\n🔐 root password change...\n'
sudo passwd

printf '\n\n🔐 password change for %s...\n' "${USERNAME}"
sudo passwd "${USERNAME}"


########
# DONE #
########
printf '\n\n✅ Done!\n'
exit 0;





