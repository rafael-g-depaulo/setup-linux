#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

# heroku cli
curl https://cli-assets.heroku.com/install-ubuntu.sh | sudo sh

sudo apt-get update -y

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
echo "# $NVM_DIR/default-packages                                           
yarn" >$NVM_DIR/default-packages
NODE_DEFAULT_VERSION=20
nvm install $NODE_DEFAULT_VERSION
# nvm install lts/fermium # v12.16
# nvm alias default lts/fermium # v12.16
nvm alias default $NODE_DEFAULT_VERSION
nvm use default

# yvm setup
curl -s https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | node
source /home/$USER/.yvm/yvm.sh

# rvm
sudo apt update
sudo apt install -y ruby

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

# docker & docker compose
# sudo apt-get install -y curl gnup ca-certificate lsb-release
### Download the docker gpg file to Ubuntu
# sudo mkdir -p /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
### Add Docker and docker compose support to the Ubuntu's packages list
# echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-pluginsudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-pluginlinux/ubuntu   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update -y

### Install docker and docker compose on Ubuntu
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

### grant docker user root permissions to run docker without sudo
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker # activate the changes without needing to log out

# yarn
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# sudo apt update && sudo apt install -y --no-install-recommends yarn
# # add this to .bashrc or .zshrc
# export PATH="$PATH:`yarn global bin`"

# yarn packages
# yarn global add create-react-app @storybook/cli nodemon @babel/cli sequelize-cli pg serve cypress typeorm lerna

# hubflow
git clone http://www.github.com/datasift/gitflow.git /tmp/hubflow
cd /tmp/hubflow
sudo ./install.sh
cd

# autojump
sudo apt-get install autojump -y

# cypress
sudo apt-get install -y libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

# neovim
sudo apt-get remove -y neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update -y
sudo apt-get install -y neovim
# clone my nvim config
git clone https://www.github.com/rafael-g-depaulo/nvim-config.git ~/.config/nvim
if [ "$VAR_IS_RAGAN" == "true" ]; then
	changeHttpsOriginToSsh ~/.config/nvim
fi

# install packer (nvim packet manager)
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
	~/.local/share/nvim/site/pack/packer/start/packer.nvim <<<yes &>/dev/null

# tmux/tmuxinator
sudo apt install -y tmux
sudo gem install tmuxinator
