################################################################################
# INFO FETCH AT STARTUP
################################################################################
if command -v neofetch >/dev/null 2>&1; then
   neofetch
elif command -v fastfetch >/dev/null 2>&1; then
   fastfetch
elif command -v screenfetch >/dev/null 2>&1; then
   screenfetch
else
   # Print hostname and OS details in one concise line
   printf '\n\033[1;32m%s \033[0;33m%s \033[0;36m%s \033[0;35m%s\033[0m\n' "$(hostname)" "$(uname -s)" "$(uname -r)" "$(uname -m)"
fi
