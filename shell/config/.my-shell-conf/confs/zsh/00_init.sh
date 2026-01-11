################################################################################
# ZSH SPECIFIC CONF.
################################################################################

# If not zsh, then exit
if [[ -z "$ZSH_VERSION" ]]; then
  return
fi

# Define variables used in prompt
export RUNNING_SHELL="ZSH"
: ${RUNNING_ENV:="LOCAL"}

################################################################################
# PROFILE VARIABLES.
################################################################################

# Source global definitions
if [[ -f /etc/zshrc ]]; then
   source /etc/zshrc
fi

################################################################################
# HISTORY MANAGEMENT.
################################################################################

# don't put duplicate lines or lines starting with space in the history.
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS

# append to the history file, don't overwrite it
setopt APPEND_HISTORY

# History size
HISTSIZE=1000000000
SAVEHIST=$HISTSIZE
HISTFILE="${HOME}/.zsh_history"

################################################################################
# BEHAVIOUR.
################################################################################

# enable programmable completion features
autoload -Uz compinit && compinit

# check the window size is handled automatically by zsh (SIGWINCH)

################################################################################
# LOOK 'N FEEL.
################################################################################

# Prompt Setup
autoload -U colors && colors

# PS1 equivalent
# Colors: 
# 00;35m (Magenta) -> %F{magenta}
# 01;34m (Bold Blue) -> %B%F{blue}
# 00;33m (Yellow) -> %F{yellow}
# 01;32m (Bold Green) -> %B%F{green}
# \W (Base dir) -> %1d

PROMPT="%F{magenta}${RUNNING_SHELL}%f%B%F{blue}@%f%b%F{yellow}${RUNNING_ENV}%f %B%F{green}%1~%f%b"

# enable color support of ls and also add handy aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
    export CLICOLOR=1
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
