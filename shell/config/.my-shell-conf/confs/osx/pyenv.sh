#!/usr/bin/env bash -x

# The following flag can be used to load pyenv just before you run it.
LAZY_LOAD_PYENV=true

function ms-pyenv-load() {
   if [ -d "$HOME/.pyenv" ] ; then
      echo -e "[ms] loading pyenv...";
      export PYENV_ROOT="$HOME/.pyenv"

      if [ -d "$PYENV_ROOT/bin" ] ; then
         # echo -e "[ms] adding pyenv bin folder to the path...";
         export PATH="$PYENV_ROOT/bin:$PATH"
      fi

      if command -v pyenv >/dev/null 2>&1
      then
         # echo -e "[ms] initializing pyenv...";
         eval "$(pyenv init --path)"
      fi 
   fi
}

if [ "$LAZY_LOAD_PYENV" = true ] ; then
  if ! command -v pyenv >/dev/null 2>&1
  then
    # The following function overrides temporarily the comand.
    pyenv2() {
      if ! command -v pyenv >/dev/null 2>&1
      then
        echo -e "[ms] pyenv not found - I am trying to load it";
        ms-pyenv-load
      fi

      unset -f pyenv
      # now invoking the pyenv provided pyenv.
      pyenv $@
    }
  fi
else
  ms-pyenv-load
fi
