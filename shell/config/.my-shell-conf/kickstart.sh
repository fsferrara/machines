################################################################################
# MY SHELL CONF.
# Source this file to load the entire configuration.
################################################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac



################################################################################
# PROFILE VARIABLES.
################################################################################

# Those are sensible defaults that may be overrided in the `host-specific` folder
function ms-define-running-env() {
  UNAME_OUTPUT="`uname -s | cut -c -5`"
  case ${UNAME_OUTPUT} in
    "Darwi")
      RUNNING_ENV="OSX"
      ;;
    "Linux")
      RUNNING_ENV="LINUX"
      ;;
    "MINGW")
      RUNNING_ENV="WINDOWS"
      ;;
     *)
      RUNNING_ENV="unknown"
      ;;
  esac
  # echo "[ms-env] RUNNING_ENV=${RUNNING_ENV}"
  export RUNNING_ENV
}
ms-define-running-env

function ms-define-running-shell() {
  RUNNING_PROCESS_COMMAND=`ps -c -p $$ -o command=`
  case ${RUNNING_PROCESS_COMMAND} in
    "-bash")
      RUNNING_SHELL="BASH"
      ;;
    "bash")
      RUNNING_SHELL="BASH"
      ;;
    "sh")
      RUNNING_SHELL="SH"
      ;;
    "-zsh")
      RUNNING_SHELL="ZSH"
      ;;
    "zsh")
      RUNNING_SHELL="ZSH"
      ;;
     *)
      RUNNING_SHELL="unknown"
      ;;
  esac
  # echo "[ms-env] RUNNING_SHELL=${RUNNING_SHELL}"
  export RUNNING_SHELL
}
ms-define-running-shell



################################################################################
# CONFIGURATION DIRECTORY.
# Sources all the scripts from a specified directory.
################################################################################
function source_dir {
   source_d=$1
   if [ -d $source_d ]; then
      for source_f in $source_d/*.sh; do
         if [ -d $source_f ]; then
            source_dir $source_f
         else
         . "$source_f"
         fi
      done
   fi
}

function my_shell_conf {
  SHELL_ADD_SETTINGS_DIR=$1
  if [ -d $SHELL_ADD_SETTINGS_DIR ]; then
     source_dir $SHELL_ADD_SETTINGS_DIR
  fi
}



################################################################################
# START THE CONFIGURATION.
# Loads the configuration specific for your shell.
################################################################################

my_shell_conf "$HOME/.my-shell-conf/confs/generic"

case ${RUNNING_SHELL} in
  "BASH")
    my_shell_conf "$HOME/.my-shell-conf/confs/bash"
    ;;
  "ZSH")
    my_shell_conf "$HOME/.my-shell-conf/confs/zsh"
    ;;
   *)    
    ;;
esac

case ${RUNNING_ENV} in
  "LINUX")
    my_shell_conf "$HOME/.my-shell-conf/confs/linux"
    ;;
  "OSX")
    my_shell_conf "$HOME/.my-shell-conf/confs/osx"
    ;;
   *)
    ;;
esac

my_shell_conf "$HOME/.my-shell-conf/host-specific"

echo "${RUNNING_SHELL}@${RUNNING_ENV} > my-shell-conf loaded!"

