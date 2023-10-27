#!/bin/bash

PROFILE=/etc/profile.d/jdp-profile.sh
CONTENTS=$(sed '/# Start of GoLang configuration/,/# End of GoLang configuration/d' $PROFILE)

IFS='' read -r -d '' K3D_PROFILE <<'END_OF_PROFILE'
# Start of GoLang configuration
if [ -d /usr/local/go/bin ]
then
  path-append /usr/local/go/bin
fi
# End of GoLang configuration
END_OF_PROFILE

echo "$CONTENTS" > $PROFILE
echo "$K3D_PROFILE" >> $PROFILE
