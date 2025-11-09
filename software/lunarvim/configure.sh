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


###########
# NPM FIX #
###########
# Resolve npm EACCES permissions when installing packages globally to avoid error when installing packages with npm.
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
npm config set prefix '~/.npm-global'
echo -e '\nexport PATH=~/.npm-global/bin:${PATH}\n' >> ~/.profile
echo -e '\nexport PATH=~/.npm-global/bin:${PATH}\n' >> ~/.zprofile


###########
# INSTALL #
###########
echo -e "LunarVim pre-requisites are now installed."
echo -e "Now follow the instructions at https://www.lunarvim.org/docs/installation\n"


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;




