#!/bin/bash

# omzcode
cd
sudo apt-get install -y zsh
CHSH=yes        # update default shell
KEEP_ZSHRC=yes  # don't override our .zshrc
RUNZSH=yes      # run zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -y
# oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# make zsh default shell
chsh -s $(which zsh)
zsh

