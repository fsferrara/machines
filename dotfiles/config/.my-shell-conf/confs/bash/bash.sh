################################################################################
# BASH SPECIFIC CONF.
################################################################################

# If not bash, then exit
if [ "${RUNNING_SHELL}" != "BASH" ]; then
  return;
fi



################################################################################
# PROFILE VARIABLES.
################################################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
   . /etc/bashrc
fi

# System profile
if [ -f /etc/profile ]; then
  . /etc/profile
fi



################################################################################
# HISTORY MANAGEMENT.
################################################################################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000



################################################################################
# BEHAVIOUR.
################################################################################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix  && [ ! "$OS" = Windows_NT ]; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize



################################################################################
# LOOK 'N FEEL.
################################################################################

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

#  prompt string
if [ "$color_prompt" = yes ]; then
    # PS1='\[\033[00;35m\]\u\[\033[01;34m\]@\[\033[00;33m\]\h\[\033[00m\]:\[\033[01;32m\]\W\[\033[00m\]'
    PS1='\[\033[00;35m\]${RUNNING_SHELL}\[\033[01;34m\]@\[\033[00;33m\]${RUNNING_ENV}\[\033[00m\] \[\033[01;32m\]\W\[\033[00m\]'
else
    # PS1='\u@\h:\W'
    PS1='${RUNNING_SHELL}@${RUNNING_ENV} \W'
fi
unset color_prompt force_color_prompt

# Git branch in prompt
parse_git_branch() {
    git branch --show-current 2> /dev/null | sed -n -e 's/^\(.*\)/[git:\1]/p'
}

COLOR_DEF='\[\033[0m\]'
COLOR_GIT='\[\033[38;5;39m\]'
export PS1="${PS1}${COLOR_GIT}\$(parse_git_branch)${COLOR_DEF}"

# Close prompt string

PS1=$PS1' > '
