#!/bin/bash

function setupFile() {
  TAG_COMMENT="$2"
  TAG_UNCOMMENT="$3"

  # comment out all lines with TAG_COMMENT
  sed -i "s|\(\s*\)\(.*\)$TAG_COMMENT|\1// \2$TAG_COMMENT|g" $1
  # uncomment out all commented lines with TAG_UNCOMMENT
  sed -i "s|\(\s*\)// \(.*\)$TAG_UNCOMMENT| \1\2$TAG_UNCOMMENT|g" $1
}

WSL_TAG="// WSL ONLY"
LINUX_TAG="// LINUX ONLY"

# get .hyper.js
cd
getgist rafael-g-depaulo .hyper.js <<<y &> /dev/null

# if in windows, just update the hyper.js
if isWindows; then
  setupFile .hyper.js $LINUX_TAG $WSL_TAG

  # TODO: send .hyper.js to windows folder
else
  # cd ~/Downloads && wget -O hyper_terminal.deb https://releases.hyper.is/download/deb # this doesnt need the correct apt repo and shit
  sudo apt-get install -y hyper

  setupFile .hyper.js $WSL_TAG $LINUX_TAG 

  # set up hyper as default terminal
  sudo update-alternatives --install $(which x-terminal-emulator) x-terminal-emulator $(which hyper) 0
  sudo update-alternatives --set x-terminal-emulator $(which hyper)
  sudo update-alternatives --config x-terminal-emulator
fi

