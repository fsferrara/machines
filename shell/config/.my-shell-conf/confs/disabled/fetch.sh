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
   echo -e "\n\033[1;32m$(hostname) \033[0;33m$(uname -o) \033[0;36m$(uname -r) \033[0;35m$(uname -m)\033[0m\n"
fi
