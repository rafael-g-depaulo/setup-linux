#!/bin/bash

sudo apt install fzf

# This file sets up the variables used elsewhere
bool_var() {
  local VARIABLE_NAME="$1"
  local VALUE=${!VARIABLE_NAME}
  local DEFAULT_VALUE="${2:-false}"

  if [ -z $VALUE ]; then
    echo $DEFAULT_VALUE
  elif [ $VALUE = "true" ]; then
    echo "true"
  else
    echo "false"
  fi
}

text_prompt() {
  # local COLORS='
  # window=,red
  # border=white,red
  # textbox=white,red
  # button=black,white
  # root=black,brightblue'

  # local dialog_command=whiptail
  # local BOXTYPE="$1"
  # local DESCRIPTION="$2"
  # local REST_ARGS="${@:3}"
  # local BASE_ARGS="--clear"

  # local COMMAND="$dialog_command $BASE_ARGS --$BOXTYPE \"$DESCRIPTION\" 0 0 3>&1 1>&2 2>&3 3>&-"
  # $dialog_command $BASE_ARGS --$BOXTYPE \"$DESCRIPTION\" 0 0 3>&1 1>&2 2>&3 3>&-

  DESCRIPTION="$1"
  DEFAULT="$2"
  echo "$(echo "" | fzf --print-query --no-info --layout=reverse --query="$DEFAULT" --prompt="$DESCRIPTION: ")"
}

option_prompt() {
  OPTIONS="$2"
  DESCRIPTION="$1"
  DELIMETER="${3:-' '}"
  echo "$OPTIONS" | tr "$DELIMETER" '\n' | fzf --print-query --no-info --layout=reverse --prompt="$DESCRIPTION: "
}

yesno_prompt () {
  RESULT=`option_prompt "$1" "yes no"`
  if [ $RESULT = "yes" ]; then
    echo "true"
  else
    echo "false"
  fi
}

# check if using non-interactive mode
export VAR_IS_INTERACTIVE="$(bool_var INTERACTIVE true)"

get_var() {
  local varname=$1
  local var=${!varname}
  local default=$2

  if [ -n "$var" ]; then
    echo $var
  elif [ "$VAR_IS_INTERACTIVE" = "false" ] && [ -n "$default" ]; then
    echo $default
  else
    return 1
  fi
}

# VARS
export VAR_IS_RAGAN=$(get_var IS_RAGAN "false" || yesno_prompt "Are you Ragan")

if [ $VAR_IS_RAGAN = "true" ]; then
  # export VAR_USER_PWD=$(get_var PASSWORD || text_prompt 'Password for postgres user')
  # export VAR_EMAIL=$(get_var EMAIL "rafael.g.depaulo@gmail.com" || text_prompt "Email" "rafael.g.depaulo@gmail.com")
  # export VAR_NAME=$(get_var NAME "Rafael G. de Paulo" || text_prompt "Nome" "Rafael G. de Paulo")
  export VAR_USER_PWD="Grape98"
  export VAR_EMAIL="rafael.g.depaulo@gmail.com"
  export VAR_NAME="Rafael G. de Paulo"
else
  export VAR_USER_PWD=$(get_var PASSWORD || text_prompt)
  export VAR_EMAIL=$(get_var EMAIL || text_prompt "Email")
  export VAR_NAME=$(get_var NAME || text_prompt "Nome")
fi  

export VAR_GIT_EDITOR=$(get_var GIT_EDITOR "code --wait" || option_prompt "Git default editor" "code --wait|code-insiders --wait|nvim|vim|nano" "|")

