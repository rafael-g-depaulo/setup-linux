#!/bin/bash

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

prompt() {
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
  COMMAND=""
  echo "$(echo "" | fzf --print-query --no-info --layout=reverse --prompt="$DESCRIPTION: ")"
}

# check if using non-interactive mode
export VAR_IS_INTERACTIVE="$(bool_var INTERACTIVE true)"

get_var() {
  local varname=$1
  local var=$(eval echo \$$varname)
  local default=$2

  if [ -n "$var" ]; then
    echo $var
  elif [ "$VAR_IS_INTERACTIVE" = "false" ] && [ -n "$default" ]; then
    echo $default
  else
    return 1
  fi
}

A=$(get_var EMAIL "rafael.g.depaulo@gmail.com" || prompt "Email")
B=$(get_var 'PASSWORD' || prompt 'Password for postgres user')

# VARS
export VAR_USER_PWD="${PASSWORD:-password_here}"
export VAR_EMAIL="${EMAIL:-rafael.g.depaulo@gmail.com}"
export VAR_NAME="${NAME:-Rafael G. de Paulo}"
export VAR_GIT_EDITOR="${GIT_EDITOR:-code --wait}"
export VAR_IS_RAGAN="${IS_RAGAN:-false}"

