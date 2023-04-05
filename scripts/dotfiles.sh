#!/bin/bash

git clone https://github.com/rafael-g-depaulo/dotfiles.git ~/dotfiles

if [ "$VAR_IS_RAGAN" == "true" ]; then
  changeHttpsOriginToSsh "~/dotfiles"
fi

cd ~/dotfiles
./importDotfiles.sh

