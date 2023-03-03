#!/bin/bash

# setup link? https://medium.com/@gusflopes86/ambiente-de-desenvolvimento-react-e-react-native-no-windows-com-wsl-f505906d636c

# THIS FIXES IT????????
# https://askubuntu.com/questions/1142359/error-0x80080005-server-execution-failed-while-installing-ubuntu-on-windows

# use this to install WSL
# https://docs.microsoft.com/en-us/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package

# For GUI Apps like Cypress
# https://nickymeuleman.netlify.app/blog/gui-on-wsl2-cypress

# VARS
USER_PWD="${PWD:-password_here}"
EMAIL="${EMAIL:-rafael.g.depaulo@gmail.com}"
NAME="${NAME:-Rafael G. de Paulo}"
GIT_EDITOR="${GIT_EDITOR:-code --wait}"

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
  CREATE USER $USER WITH PASSWORD '$USER_PWD)';
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

#make symlink to C:/
# mkdir /mnt/c/projects &> /dev/null
# ln -s /mnt/c/projects &> /dev/null

# ssh keys
cp -r /mnt/c/Users/${USER}/.ssh ~/.
sudo chmod 700 -R ~/.ssh
SSH_KEY_ALG=ed25519
ssh-keygen -q -t $SSH_KEY_ALG -C "$EMAIL" -f "$HOME/.ssh/id_$SSH_KEY_ALG" -P "" <<< n &> /dev/null
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_$SSH_KEY_ALG

# git and gitflow (now using hubflow instead)
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global core.editor "$GIT_EDITOR"
# Alias for existing commands
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.br branch
# Push only the branch you are now working on
git config --global push.default simple
# Make --rebase the default behavior during git pull
git config --global pull.rebase true
# Make --prune the default behavior during git fetch
git config --global fetch.prune true
# Set the width of indentation for tab characters
git config --global core.pager 'less -x4'
# set default branch as main
git config --global init.defaultBranch main

# add github to known hosts (this saves a confirmation later)
mkdir ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts

# idk if i want this yet
# # Do not fast-forward when merging
# git config --global --add merge.ff false
# git config --global --add pull.ff only

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

# # if ubuntu 18.04+
# sudo apt-get install -y git-flow
# # if not ubuntu 18.04+
# # wget -q  https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh && sudo bash gitflow-installer.sh install stable; rm gitflow-installer.sh
# # git config --global core.editor "${VSCODE_EDITOR:-code} --wait"

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

# clone my personal commands
git clone git@github.com:rafael-g-depaulo/bash-commands.git ~/commands <<<yes &> /dev/null
export PATH="$PATH:$HOME/commands" # temporarily add commands to path

# hyper terminal
sudo apt-get install -y hyper
mkdir -p ~/.config/Hyper
cd ~/.config/Hyper
getgist rafael-g-depaulo .hyper.js <<<n &> /dev/null
function addComment() {
  TAG="$2"
  sed -i "s|\(\s*\)\(.*\)$TAG|\1// \2$TAG|g" $1
}
function removeComment() {
  TAG="$2"
  sed -i "s|\(\s*\)// \(.*\)$TAG| \1\2$TAG|g" $1
}
if isWindows; then
  removeComment .hyper.js "// WSL ONLY" # uncomment all WSL specific config 
  addComment .hyper.js "// LINUX ONLY" # comment out all native linux specific config
else
  removeComment .hyper.js "// LINUX ONLY" # uncomment all native linux specific config 
  addComment .hyper.js "// WSL ONLY" # comment out all WSL specific config
fi

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

# clone setup.env (this file :D! hii!) in my setup folder
mkdir ~/setup 
cd ~/setup 
getgist rafael-g-depaulo setup-env.sh

# omzcode
cd
sudo apt-get install -y zsh
CHSH=yes        # update default shell
KEEP_ZSHRC=yes  # don't override our .zshrc
RUNZSH=yes      # run zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -y
getgist rafael-g-depaulo .zshrc -y
# oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# make zsh default shell
chsh -s $(which zsh)
zsh

# TODO: auto setup fonts (https://www.nerdfonts.com/font-downloads)
# TODO: set this up as a github repo and separate files
# TODO: make this interactive

