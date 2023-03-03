#!/bin/bash

# this file installs my custom commands

git clone git@github.com:rafael-g-depaulo/bash-commands.git ~/commands <<<yes &> /dev/null
export PATH="$PATH:$HOME/commands" # temporarily add commands to path

