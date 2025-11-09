#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_APPLY="rsync -av"


#########
# APPLY #
#########
echo -e "\n\n🔌 Configuring...\n";
${CMD_APPLY} config/ ~

echo -e "\n\n🚀 Configuring rbenv...\n";
rbenv init


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
