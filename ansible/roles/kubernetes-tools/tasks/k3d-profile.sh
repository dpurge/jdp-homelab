#!/bin/bash

PROFILE=/etc/profile.d/jdp-profile.sh
CONTENTS=$(sed '/# Start of K3D configuration/,/# End of K3D configuration/d' $PROFILE)

IFS='' read -r -d '' K3D_PROFILE <<'END_OF_PROFILE'
# Start of K3D configuration
if [ -x /usr/local/bin/k3d ]
then
  source <(/usr/local/bin/k3d completion bash)
fi
# End of K3D configuration
END_OF_PROFILE

echo "$CONTENTS" > $PROFILE
# printf "\n" >> $PROFILE
echo "$K3D_PROFILE" >> $PROFILE
