#!/bin/bash

PROFILE=/etc/profile.d/jdp-profile.sh
PATH_ENTRY=/usr/local/go/bin
PATH_CMD=path-append

if [ -d $PATH_ENTRY ] && ! grep --fixed-strings --line-regexp --quiet "$PATH_CMD $PATH_ENTRY" $PROFILE
then
    printf "\n# GoLang path\n" >> $PROFILE
    echo "$PATH_CMD $PATH_ENTRY" >> $PROFILE
    printf "\n" >> $PROFILE
fi
