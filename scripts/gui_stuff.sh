#!/bin/bash

mkdir -p ~/Downloads
cd ~/Downloads/

# install google chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb 

# install vs code insiders
BASE_URL="https://code.visualstudio.com/sha/download?build=insider&os=linux-deb-x64"
PACKAGE_URL=$(curl "$BASE_URL" | sed 's|.*Redirecting to \(.*\)|\1|')
curl $PACKAGE_URL --output vscode-insiders.deb
sudo apt install -y ./vscode-insiders.deb

# install spotify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install -y spotify-client

# install steam
sudo add-apt-repository -y multiverse
sudo apt update
sudo apt install -y steam

# install discord
wget -O ./discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install -y ./discord.deb

# install vlc media player
sudo apt install -y vlc

# gnome connector to install extensions through chrome
sudo apt-get install chrome-gnome-shell

# gui volume mixer
# sudo apt install -y qasmixer

# TODO: obsidian
# TODO: beekeeper
# TODO: stremio

