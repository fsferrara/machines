#!/usr/bin/env bash

install_plantuml(){
   brew install libtool
   brew link libtool
   brew install graphviz
   brew link --overwrite graphviz
}

install_plantuml

