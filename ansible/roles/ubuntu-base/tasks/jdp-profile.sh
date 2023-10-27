#!/bin/bash

PROFILE=/etc/profile.d/jdp-profile.sh
if ! [ -f /etc/profile.d/jdp-profile.sh ]
then
    touch $PROFILE
    chown root:root $PROFILE
fi

CONTENTS=$(sed '/# Start of common configuration/,/# End of common configuration/d' $PROFILE)


IFS='' read -r -d '' COMMON_PROFILE <<'END_OF_PROFILE'
# Start of common configuration
function path-append {
    for ARG in "$@"
    do
        if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]
        then
            PATH="${PATH:+"$PATH:"}$1"
        fi
    done
    export PATH
}

function path-prepend {
    for ((i=$#; i>0; i--)); 
    do
        ARG=${!i}
        if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
            PATH="$ARG${PATH:+":$PATH"}"
        fi
    done
    export PATH
}

function path-remove {
    PATH=:$PATH:
    PATH=${PATH//:$1:/:}
    PATH=${PATH#:}
    PATH=${PATH%:}
    export PATH
}
# End of common configuration
END_OF_PROFILE

echo "$COMMON_PROFILE" > $PROFILE
# printf "\n" >> $PROFILE
echo "$CONTENTS" >> $PROFILE