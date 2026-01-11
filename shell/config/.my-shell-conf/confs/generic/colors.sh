################################################################################
# COMMON SHELL CONFIGURATION
# This file contains configuration that works across bash, zsh, and other shells
################################################################################

################################################################################
# ENVIRONMENT VARIABLES
################################################################################

# Set default running environment if not already set
: ${RUNNING_ENV:="LOCAL"}

################################################################################
# LOOK 'N FEEL
################################################################################

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    export CLICOLOR=1
    alias ls='ls -G'
elif [ -x /usr/bin/dircolors ]; then
    # Linux with dircolors
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
else
    # Fallback
    alias ls='ls --color=auto'
fi

# Color support for grep commands
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
