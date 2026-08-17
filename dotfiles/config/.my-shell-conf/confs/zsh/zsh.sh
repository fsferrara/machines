################################################################################
# ZSH SPECIFIC CONF.
################################################################################

# If not zsh, then exit
if [ -z "${ZSH_VERSION:-}" ]; then
  return
fi

# Define variables used in prompt
export RUNNING_SHELL="ZSH"

################################################################################
# PROFILE VARIABLES.
################################################################################

# Source global definitions
if [ -f /etc/zshrc ]; then
  . /etc/zshrc
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

COLOR_DEF=$'%f'
# Git branch in prompt requires ../generic/git-prompt.sh
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
PROMPT_CWD='${COLOR_GIT}$(__git_ps1 "[git:%s]")${COLOR_DEF}'
export PROMPT="${PROMPT}${PROMPT_CWD}"

# Close prompt string

PS1=$PS1' > '

################################################################################
