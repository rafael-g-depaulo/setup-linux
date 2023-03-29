#!/bin/bash

# this file installs my custom commands

COMMANDS_DIR="$HOME/commands"
if [ -d  $COMMANDS_DIR ] && [ "$(ls -A $COMMANDS_DIR)" ]; then
  echo "Commands directory exists and isn't empty. Skipping custom commands"
  exit
fi

git clone https://github.com/rafael-g-depaulo/bash-commands.git ~/commands

if [ "$VAR_IS_RAGAN" == "true" ]; then 
  changeHttpsOriginToSsh "$COMMANDS_DIR"
fi

