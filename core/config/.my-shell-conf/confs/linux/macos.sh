################################################################################
# MacOS Commands on Linux
################################################################################

# Clipboard
# Use xsel to emulate pbcopy and pbpaste on Linux
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Open files with the default application
open() (
  xdg-open "$@" >/dev/null 2>&1 &
)
