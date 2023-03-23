#!/bin/bash
# sudo -u $USER bash -c "$(curl "https://raw.githubusercontent.com/rafael-g-depaulo/setup-linux/main/main.sh")"

# setup if using a naked ubuntu
sudo apt update -y
sudo apt install -y git
mkdir -p ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts

# clone and run scripts
git clone https://github.com/rafael-g-depaulo/setup-linux.git ~/setup 
cd ~/setup
sudo -u $USER bash -c "$(cat ./main.sh)"

