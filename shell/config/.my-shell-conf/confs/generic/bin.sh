################################################################################
# BIN folders
################################################################################

## Machine
MACHINE_BIN="${HOME}/.local/bin"
if [ -d ${MACHINE_BIN} ]; then
   PATH="${MACHINE_BIN}:${PATH}"
fi

## User bin
export BIN_USER="${HOME}/bin"
if [ -d "$BIN_USER" ] ; then
    PATH="$BIN_USER:${PATH}"
fi

export PATH

