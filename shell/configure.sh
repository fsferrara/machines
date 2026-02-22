#! /usr/bin/env bash

set -e
set -u


########
# HELP #
########
function help() {
    echo -e "\nUsage: $0 [destination]\n"
    echo -e "destination: The folder where the configuration will be applied. Default is the home directory.\n"
    exit 0;
}

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    help
fi


#########
# INPUT #
#########
DESTINATION=${1:-${HOME}}


##########
# CONFIG #
##########
CMD_APPLY="rsync -av"


#########
# APPLY #
#########
echo -e "\n\n🔌 Configuring...\n";
${CMD_APPLY} config/ ${DESTINATION}

echo -e "(!) If needed, source the kickstart when your shell starts! Examples:"
echo -e 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.bashrc'
echo -e 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.zshrc'


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
