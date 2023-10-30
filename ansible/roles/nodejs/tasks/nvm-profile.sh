#!/bin/bash

PROFILE=/etc/profile.d/jdp-profile.sh
CONTENTS=$(sed '/# Start of NVM configuration/,/# End of NVM configuration/d' $PROFILE)

IFS='' read -r -d '' NVM_PROFILE <<'END_OF_PROFILE'
# Start of NVM configuration
export NVM_DIR="$HOME/.nvm"
if [ -s /usr/local/nvm/nvm.sh ]
then
  source /usr/local/nvm/nvm.sh
fi
if [ -s /usr/local/nvm/bash_completion ]
then
  source /usr/local/nvm/bash_completion
fi
# End of NVM configuration
END_OF_PROFILE

echo "$CONTENTS" > $PROFILE
echo "$NVM_PROFILE" >> $PROFILE
