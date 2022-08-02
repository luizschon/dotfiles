#! /usr/bin/env bash

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
STOW_CONFIG_PATH="$SCRIPT_PATH/config.d"
STOW_HOME_PATH="$SCRIPT_PATH/home.d"
CONFIG_PATH="$HOME/.config"

stow -Svvv --dotfiles --no-folding -d $SCRIPT_PATH -t $CONFIG_PATH config.d
stow -Svvv --dotfiles --no-folding -d $SCRIPT_PATH -t $HOME home.d
