#!/bin/bash

# download and install nerd font for fira code (with ligatures)

FONT_NAME="FiraCode"

RELEASE_ID=$(gh api /repos/ryanoasis/nerd-fonts/releases/latest | jq '.id')
ASSET_ID=$(gh api /repos/ryanoasis/nerd-fonts/releases/$RELEASE_ID/assets | jq "map(select(.name == \"$FONT_NAME.zip\")) | .[0].id")
DOWNLOAD_URL=$(gh api /repos/ryanoasis/nerd-fonts/releases/assets/$ASSET_ID | jq '.browser_download_url')

# my installFont custom command. check custom_commands.sh for more info 
installFont $DOWNLOAD_URL

