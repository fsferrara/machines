#! /usr/bin/env sh
set -e
set -u

LOG_TAG=${0}
printf '[%s] executing...\n' "$LOG_TAG"

CURRENT_VERSION=$(curl -Ls https://api.github.com/repos/Versent/saml2aws/releases/latest | grep 'tag_name' | cut -d'v' -f2 | cut -d'"' -f1)
wget -c "https://github.com/Versent/saml2aws/releases/download/v${CURRENT_VERSION}/saml2aws_${CURRENT_VERSION}_linux_amd64.tar.gz" -O - | tar -xzv -C ~/.local/bin
chmod u+x ~/.local/bin/saml2aws
hash -r
saml2aws --version

printf '[%s] completed ;)\n' "$LOG_TAG"
exit 0;
