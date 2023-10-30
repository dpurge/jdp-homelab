#!/bin/bash

NVM_DIR=/usr/local/nvm

if [ -d "${NVM_DIR}" ]
then
  pushd "${NVM_DIR}"
  git pull
  popd
else
  git -c advice.detachedHead=0 clone --depth 1 https://github.com/nvm-sh/nvm.git "${NVM_DIR}"
fi