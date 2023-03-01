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

# clone linux scripts in ~/setup and run them 
# (this is all that this file should do)

# TODO: auto setup fonts (https://www.nerdfonts.com/font-downloads)
# TODO: set this up as a github repo and separate files
# TODO: make this interactive

