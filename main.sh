#!/bin/bash

# parse input and get vars
source ./scripts/setup_vars.sh

# setup custom commands
source ./scripts/custom_commands.sh

# install tools and cli stuff
source ./scripts/tools.sh

# setup terminal emulator
source ./scripts/terminal.sh

# install zsh and oh-my-zsh
source ./scripts/zsh.sh

isWindows || source ./scripts/setup_fonts.sh

# TODO: make this interactive

