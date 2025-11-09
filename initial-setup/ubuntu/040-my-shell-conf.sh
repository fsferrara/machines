#!/usr/bin/env bash

LOG_TAG=${0}
echo -e "[${LOG_TAG}] executing...";

cd ~ || exit
ln -s ~/github/fsferrara/machines/configuration/shell/.my-shell-conf .my-shell-conf
cd - || exit

echo -e "\n#My Shell Configuration\nsource ~/.my-shell-conf/kickstart.sh\n" >> ~/.bashrc
echo -e "\n#My Shell Configuration\nsource ~/.my-shell-conf/kickstart.sh\n" >> ~/.zshrc

echo -e "[${LOG_TAG}] completed ;)";
exit 0;
