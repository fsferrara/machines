################################################################################
# PBCOPY and PBPASTE
# Since Linux and Mac OS X are \*Nix based systems, many commands would work on both platforms. However, some commands may not available on both platforms, for example pbcopy and pbpaste. These commands are exclusively available only on Mac OS X platform. The Pbcopy command will copy the standard input into clipboard. You can then paste the clipboard contents using Pbpaste command wherever you want. Of course, there could be some Linux alternatives to the above commands, for example Xclip. The Xclip utility is similar to Pbcopy. But, the distro-hoppers who switched to Linux from Mac OS would miss this command-pair and still prefer to use them. No worries! This brief tutorial describes how to use Pbcopy and Pbpaste commands on Linux.
# Pre-requisites: sudo apt install xsel
################################################################################

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
