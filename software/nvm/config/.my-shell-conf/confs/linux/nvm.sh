# The following flag can be used to load nvm just before you run node.
# I suggest to set it to false if you'll be load nvm manually or at the shell startup. 
LAZY_LOAD_NVM=false

ms_nvm_load() {
   printf '%s\n' "[ms] loading nvm...";
   export NVM_DIR="$HOME/.nvm"
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

if [ "$LAZY_LOAD_NVM" = true ] ; then

  # The following function overrides temporarily the node command in order to load nvm before using the actual node.
  node() {
    if ! command -v nvm >/dev/null 2>&1
    then
      printf '%s\n' "[ms] nvm not found - I am trying to load it";
      ms_nvm_load
    fi

    unset -f node
    # now invoking the nvm provided node.
    node "$@"
  }
else
  ms_nvm_load
fi
