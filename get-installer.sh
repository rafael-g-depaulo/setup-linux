#!/bin/bash
# sudo -u $USER bash -c "$(curl "https://raw.githubusercontent.com/rafael-g-depaulo/setup-linux/main/main.sh")"

git clone https://github.com/rafael-g-depaulo/setup-linux.git ~/setup 
cd ~/setup
sudo -u $USER bash -c "$(cat ./main.sh)"
