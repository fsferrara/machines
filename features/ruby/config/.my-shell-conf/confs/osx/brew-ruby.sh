################################################################################
# Brew Ruby
################################################################################

# On Apple silicon
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
  export PATH=`gem environment gemdir`/bin:$PATH
fi

# IF THE ABOVE CONFING DOES NOT WORK
#The problem is that the configuration in `/etc/profile` is reordering the `$PATH` env variable using an utility named `path_helper`. The solution is to comment out this configuration:

# ```shell:/etc/profile
# # System-wide .profile for sh(1)

# #if [ -x /usr/libexec/path_helper ]; then
# #	eval `/usr/libexec/path_helper -s`
# #fi

# if [ "${BASH-no}" != "no" ]; then
#   [ -r /etc/bashrc ] && . /etc/bashrc
# fi
# ```
