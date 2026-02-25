################################################################################
# SSH AUTOCOMPLETE.
################################################################################

# fix: check ~/.ssh/known_hosts exists before running the command
if [ -f ~/.ssh/known_hosts ]; then
    complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi
