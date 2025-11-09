#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo apt update"
CMD_INSTALL="sudo apt install -y"
CMD_APPLY="rsync -av"


########
# EXEC #
########
echo -e "\n\n🚀 Generating signatures for all public keys...\n"
for file in ./config/.ssh/*.pub; do
    echo -e "key: $file"
    ssh-keygen -lf $file -E sha256
    echo -e "\n"
done

########
# DONE #
########
echo -e "✅ Done!\n";
exit 0;
