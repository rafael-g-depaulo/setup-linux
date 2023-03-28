#!/bin/bash

# parse input and get vars
source ./scripts/setup_vars.sh

# setup custom commands
source ./scripts/custom_commands.sh

# cli utils
source ./scripts/cli_utils.sh

# setup general config stuff
source ./scripts/config.sh

# install tools
source ./scripts/tools.sh

# setup terminal emulator
if [ $VAR_HAS_GUI = "true" ]; then
  source ./scripts/gui_stuff.sh
  source ./scripts/setup_fonts.sh

  if [ $VAR_INSTALL_HYPER = "true" ]; then
    source ./scripts/terminal.sh
  fi
fi

# install zsh and oh-my-zsh
if [ $VAR_INSTALL_ZSH = "true" ]; then
  source ./scripts/zsh.sh
fi

