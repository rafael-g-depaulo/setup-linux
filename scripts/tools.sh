#!/bin/bash

# heroku cli (recommend to keep this at the stop since it's the only one that prompts a password)
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

sudo apt-get update -y

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
echo "# $NVM_DIR/default-packages                                           
yarn" > $NVM_DIR/default-packages
nvm install 18
# nvm install lts/fermium # v12.16
# nvm alias default lts/fermium # v12.16
nvm alias default 18
nvm use default

# yvm setup
curl -s https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | node
source /home/$USER/.yvm/yvm.sh

# postgres setup
sudo apt-get install -y postgresql postgresql-contrib libpq-dev
sudo service postgresql start
sudo -u postgres psql -c "
  CREATE USER $USER WITH PASSWORD '$VAR_USER_PWD)';
  ALTER USER $USER WITH SUPERUSER;
"
sudo systemctl enable postgresql

# create db
# sudo -u postgres psql -c "
#  CREATE DATABASE \"plural\";
# "

# yarn
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# sudo apt update && sudo apt install -y --no-install-recommends yarn
# # add this to .bashrc or .zshrc
# export PATH="$PATH:`yarn global bin`"

# yarn packages
# yarn global add create-react-app @storybook/cli nodemon @babel/cli sequelize-cli pg serve cypress typeorm lerna

# Github cli
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update -y \
  && sudo apt install gh -y

# hubflow
git clone http://www.github.com/datasift/gitflow.git /tmp/hubflow
cd /tmp/hubflow
sudo ./install.sh
cd

# python basics
sudo apt-get install -y python-is-python3 pip

# autojump
sudo apt-get install autojump -y

# cypress
sudo apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

# utils
sudo apt-get install -y make xclip vim 
pip install getgist
export PATH="$PATH:$HOME/.local/bin"

# neovim
sudo apt-get remove -y neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update -y
sudo apt-get install -y neovim
# clone my nvim config
git clone https://www.github.com/rafael-g-depaulo/nvim-config.git ~/.config/nvim
# install packer (nvim packet manager)
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim <<<yes &> /dev/null

# jq is a nice tool to manipulate json strings in terminal (useful for curl'ing apis)
sudo apt-get install jq

