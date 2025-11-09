#!/usr/bin/env bash


##########
# CONFIG #
##########
CMD_UPDATE="sudo dnf check-update"
CMD_INSTALL="sudo dnf install --assumeyes "


##########
# UPDATE #
##########
echo -e "\n\n🛸 Updading...\n";
${CMD_UPDATE}


###########
# INSTALL #
###########
echo -e "\n\n🚀 Installing...\n";
${CMD_INSTALL} swift-lang swiftlint

# When running `swift repl` you may get this error:
# ".local/share/swiftly/toolchains/6.1.2/usr/bin/lldb: error while loading shared libraries: libpython3.12.so.1.0: cannot open shared object file: No such file or directory"
# To fix it, install the python version it is looking for.
${CMD_INSTALL} python312


########
# DONE #
########
echo -e "\n\n✅ Done!\n";
exit 0;
