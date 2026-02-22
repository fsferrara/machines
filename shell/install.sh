#! /usr/bin/env bash

set -e
set -u

##########
#  USER  #
##########
su - ${_REMOTE_USER}

#########
# APPLY #
#########
./configure.sh "${_REMOTE_USER_HOME}"
