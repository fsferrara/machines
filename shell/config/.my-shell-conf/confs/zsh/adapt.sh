################################################################################
# Config ZSH to behave like Bash in certain aspects
################################################################################

# Comments
setopt interactivecomments
# Correct minor spelling errors in path names when using `cd`
setopt correct
# Allow changing to a directory by just typing its name if it's in the CDPATH
setopt auto_cd
# Share command history across all sessions
setopt share_history
# Extended globbing features: ** for recursive matching, etc.
setopt extended_glob
# Treat unset variables as an error when substituting
setopt nounset
# Make glob patterns match dotfiles (hidden files starting with .)
setopt glob_dots
# Disable the beep sound on errors
setopt no_beep
# Don't error when glob patterns don't match any files (pass them literally like Bash)
setopt no_nomatch
# Perform word splitting on unquoted parameter expansions (like Bash/sh)
setopt sh_word_split
# Make regex operator =~ set BASH_REMATCH array (like Bash)
setopt bash_rematch
