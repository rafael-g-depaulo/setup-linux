#!/bin/bash

# this file installs my custom commands

git clone https://github.com/rafael-g-depaulo/bash-commands.git ~/commands
export PATH="$PATH:$HOME/commands" # temporarily add commands to path

if [ "$VAR_IS_RAGAN" == "true" ]; then 
  echo "you are ragan"
else
  echo "you are not ragan, you nerd"
fi

