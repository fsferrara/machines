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
printf '\n\n🚀 Generating signatures for all public keys...\n'
for file in ./config/.ssh/*.pub; do
    printf 'key: %s\n' "$file"
    ssh-keygen -lf $file -E sha256
    printf '\n'
done

########
# DONE #
########
printf '✅ Done!\n'
exit 0;
