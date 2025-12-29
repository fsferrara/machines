#! /usr/bin/env bash

set -e
set -u
set -o pipefail


##########
# CONFIG #
##########
CMD_APPLY="rsync -av"


#########
# APPLY #
#########
echo -e "\n\n🔌 Configuring...\n";
${CMD_APPLY} config/ ~

echo -e "(!) Source the kickstart when your shell starts! Examples:"
echo -e 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.bashrc'
echo -e 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.zshrc'


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
