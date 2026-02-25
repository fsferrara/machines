#! /usr/bin/env sh

set -e
set -u


brew update

INSTCMD="brew install"

$INSTCMD vim
$INSTCMD fzf
$INSTCMD the_silver_searcher
$INSTCMD ripgrep
$INSTCMD git-delta
$INSTCMD bat

