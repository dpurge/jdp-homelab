#!/bin/bash

PROFILE=/etc/profile.d/jdp-profile.sh
CONTENTS=$(sed '/# Start of PyEnv configuration/,/# End of PyEnv configuration/d' $PROFILE)

IFS='' read -r -d '' PYENV_PROFILE <<'END_OF_PROFILE'
# Start of PyEnv configuration
export PYENV_SHELL=bash
if [ -d /usr/local/pyenv/bin ]
then
  path-prepend /usr/local/pyenv/bin
fi
if [ -d $HOME/.pyenv/shims ]
then
  path-prepend $HOME/.pyenv/shims
fi
eval "$(pyenv init -)"
# End of PyEnv configuration
END_OF_PROFILE

echo "$CONTENTS" > $PROFILE
echo "$PYENV_PROFILE" >> $PROFILE
