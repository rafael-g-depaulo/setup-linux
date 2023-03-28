#!/bin/bash

# parse input and get vars
source ./scripts/setup_vars.sh

# setup custom commands
source ./scripts/custom_commands.sh

# cli utils
source ./scripts/cli_utils.sh

# install tools
source ./scripts/tools.sh

# setup terminal emulator
if [ $VAR_HAS_GUI = "true" ] && [ $VAR_INSTALL_HYPER = "true" ]; then
  source ./scripts/terminal.sh
fi

# install zsh and oh-my-zsh
# source ./scripts/zsh.sh

# isWindows || source ./scripts/setup_fonts.sh

# TODO: make this interactive

