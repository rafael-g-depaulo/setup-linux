#!/bin/bash

# TODO: add rvm/ruby/tmuxinator to tools.sh

SETUP_BASE="$(pwd)"
run_script() {
  local SCRIPT_NAME="$1"
  local SCRIPTS_FOLDER="$SETUP_BASE/scripts"

  # run script
  sudo "$SCRIPTS_FOLDER/$SCRIPT_NAME"
}

# PATH CHANGES
export PATH="$PATH:$HOME/.local/bin" # needed for getgist
export PATH="$PATH:$HOME/commands"   # temporarily add commands to path

# parse input and get vars
source ./scripts/setup_vars.sh

# setup custom commands
run_script "custom_commands.sh"

# cli utils
run_script "cli_utils.sh"

# get my dotfiles for general config
run_script "dotfiles.sh"

# setup general config stuff
run_script "config.sh"

# install tools
run_script "tools.sh"

# setup terminal emulator
if [ $VAR_HAS_GUI = "true" ]; then
  run_script "gui_stuff.sh"
  run_script "setup_fonts.sh"

  if [ $VAR_INSTALL_HYPER = "true" ]; then
    run_script "terminal.sh"
  fi
fi

# install zsh and oh-my-zsh
if [ $VAR_INSTALL_ZSH = "true" ]; then
  run_script "zsh.sh"
fi

