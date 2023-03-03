#!/bin/bash

# configure stuff

# git and gitflow (now using hubflow instead)
git config --global user.name "$VAR_NAME"
git config --global user.email "$VAR_EMAIL"
git config --global core.editor "$VAR_GIT_EDITOR"
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

# idk if i want this yet
# # Do not fast-forward when merging
# git config --global --add merge.ff false
# git config --global --add pull.ff only

# add github to known hosts (this saves a confirmation later)
mkdir ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts

# ssh keys
isWindows && cp -r /mnt/c/Users/${USER}/.ssh ~/.
sudo chmod 700 -R ~/.ssh
SSH_KEY_ALG=ed25519
ssh-keygen -q -t $SSH_KEY_ALG -C "$VAR_EMAIL" -f "$HOME/.ssh/id_$SSH_KEY_ALG" -P "" <<< n &> /dev/null
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_$SSH_KEY_ALG

