#!/bin/bash

# install cli utility tools

# utils
sudo apt-get install -y make xclip vim tree fzf curl

# python basics
sudo apt-get install -y python-is-python3 pip

# getgist (util to download github gists)
pip install getgist

# jq is a nice tool to manipulate json strings in terminal (useful for curl'ing apis)
sudo apt-get install -y jq

# stow is what we use to manage dotfiles
sudo apt install -y stow

# Github cli
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
	sudo apt update -y &&
	sudo apt install gh -y
