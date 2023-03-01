#!/bin/bash

function addComment() {
  TAG="$2"
  sed -i "s|\(\s*\)\(.*\)$TAG|\1// \2$TAG|g" $1
}
function removeComment() {
  TAG="$2"
  sed -i "s|\(\s*\)// \(.*\)$TAG| \1\2$TAG|g" $1
}

WSL_TAG="// WSL ONLY"
LINUX_TAG="// LINUX ONLY"

# get .hyper.js
cd
getgist rafael-g-depaulo .hyper.js <<<y &> /dev/null

# if in windows, just update the hyper.js
if isWindows; then
  removeComment .hyper.js $WSL_TAG # uncomment all WSL specific config 
  addComment .hyper.js $LINUX_TAG # comment out all native linux specific config

  # TODO: send .hyper.js to windows folder
else
  sudo apt-get install -y hyper
  removeComment .hyper.js $LINUX_TAG # uncomment all native linux specific config 
  addComment .hyper.js $WSL_TAG # comment out all WSL specific config

  # set up hyper as default terminal
  sudo update-alternatives --set x-terminal-emulator $(which hyper)
  sudo update-alternatives --config x-terminal-emulator
fi

