#!/bin/bash

PYENV_ROOT=/usr/local/pyenv

if [ -d "${PYENV_ROOT}" ]
then
  pushd "${PYENV_ROOT}"
  git pull
  popd
else
  git -c advice.detachedHead=0 clone --depth 1 https://github.com/pyenv/pyenv.git "${PYENV_ROOT}"
fi

if [ -d "${PYENV_ROOT}/plugins/pyenv-doctor" ]
then
  pushd "${PYENV_ROOT}/plugins/pyenv-doctor"
  git pull
  popd
else
  git -c advice.detachedHead=0 clone --depth 1 https://github.com/pyenv/pyenv-doctor.git "${PYENV_ROOT}/plugins/pyenv-doctor"
fi

if [ -d "${PYENV_ROOT}/plugins/pyenv-update" ]
then
  pushd "${PYENV_ROOT}/plugins/pyenv-update"
  git pull
  popd
else
  git -c advice.detachedHead=0 clone --depth 1 https://github.com/pyenv/pyenv-update.git "${PYENV_ROOT}/plugins/pyenv-update"
fi

if [ -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]
then
  pushd "${PYENV_ROOT}/plugins/pyenv-virtualenv"
  git pull
  popd
else
  git -c advice.detachedHead=0 clone --depth 1 https://github.com/pyenv/pyenv-virtualenv.git "${PYENV_ROOT}/plugins/pyenv-virtualenv"
fi
