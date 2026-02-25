################################################################################
# BIN folders
################################################################################

## User bin
export BIN_USER="${HOME}/bin"
if [ -d "$BIN_USER" ] ; then
    PATH="$BIN_USER:${PATH}"
fi

## User private bin
BIN_PRIVATE="${HOME}/.local/bin"
if [ -d ${BIN_PRIVATE} ]; then
   PATH="${BIN_PRIVATE}:${PATH}"
fi

export PATH
