#! /usr/bin/env sh

set -e
set -u


install_plantuml(){
   brew install libtool
   brew link libtool
   brew install graphviz
   brew link --overwrite graphviz
}

install_plantuml

