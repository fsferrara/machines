#! /usr/bin/env sh

set -e
set -u


DESTINATION=${1:-${HOME}}
printf '\n\n🟢 Starting post-configuration...\n'
printf 'DESTINATION: %s\n' "${DESTINATION}"


printf '(!) If needed, source the kickstart when your shell starts! Examples:\n'
printf 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.bashrc\n'
printf 'echo -e "\\n#My Shell Configuration\\nsource ~/.my-shell-conf/kickstart.sh\\n" >> ~/.zshrc\n'


exit 0
