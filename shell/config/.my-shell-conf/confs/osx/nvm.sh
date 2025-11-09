#!/usr/bin/env bash -x

# The following flag can be used to load nvm just before you run node.
# I suggest to set it to false if you'll be load nvm manually or at the shell startup. 
LAZY_LOAD_NVM=true

function ms-nvm-load() {
   echo -e "[ms] loading nvm...";
   export NVM_DIR="$HOME/.nvm"
   [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
   [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
}

if [ "$LAZY_LOAD_NVM" = true ] ; then

  # The following function overrides temporarily the node command in order to load nvm before using the actual node.
  node() {
    if ! command -v nvm &> /dev/null
    then
      echo -e "[ms] nvm not found - I am trying to load it";
      ms-nvm-load
    fi

    unset -f node
    # now invoking the nvm provided node.
    node $@
  }
else
  ms-nvm-load
fi
