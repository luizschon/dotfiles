#! /usr/bin/env bash

WALLPAPERS_DIR=$HOME/.config/i3/assets/wallpapers
cd $WALLPAPERS_DIR

create_theme() {
	wal -n -i $1
	feh --bg-fill $1
}

rand_img=$(ls | sort -R | tail -1)
create_theme $rand_img
 
exit
