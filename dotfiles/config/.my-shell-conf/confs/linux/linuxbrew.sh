BREW_CMD=/home/linuxbrew/.linuxbrew/bin/brew 
if [ -f "$BREW_CMD" ]; then
   eval "$(${BREW_CMD} shellenv)"
fi

