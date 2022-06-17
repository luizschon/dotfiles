#! /usr/bin/env bash

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
CONFIG_PATH="$HOME/.config"

create_backup () {
	dir=$(basename $1)
	parent_dir=$(dirname $1)
	mv $1 ${parent_dir}/~${dir}
}

link_file() {
	filename=$(basename $1)
	base_path=$(realpath $1)
	target_path=$(realpath $2)
	ln -sf $base_path $target_path && echo "Linked $filename to $target_path"
	echo ""
}

link_dir_to_config() {
	dir_name=$(basename $1)
	base_dir=$(realpath $1)
	target_dir=${CONFIG_PATH}/${dir_name}

	if [ -d $target_dir ]; then
		echo "Target directory already exists! Creating backup and removing"
		create_backup $target_dir
	fi

	cd $CONFIG_PATH
	ln -sT $base_dir ./$dir_name && echo "Linked $dir_name config to $target_dir"
	echo ""
	cd $SCRIPT_PATH
}

# Turn every bash script inside the .dotfiles directory executable
find -L -regex ".*\.sh" -exec chmod +x {} \;

# Link directories to .config dir
link_dir_to_config "zsh"
link_file ".zshenv" ${HOME} # Links .zshenv file to home folder
link_dir_to_config "kitty"
link_dir_to_config "i3"
link_dir_to_config "polybar"
link_dir_to_config "rofi"
link_dir_to_config "picom"

. "${SCRIPT_PATH}/gituser.conf"

git_name=$name
git_email=$email
git_gpgkeyid=$gpg_keyid

# Checks if name and email where informed in gituser.conf
if [[ -z $git_name ]] || [[ -z $git_email ]]; then
	echo "User and/or email not set, git config folder won't be linked!"
else
	link_dir_to_config "git"
	
	# Inserts name and email into git config
	git config --global user.name ${git_name}
	git config --global user.email ${git_email}

	# Enables GPG commit signing if gpg_keyid is provided
	if [ -n $git_gpgkeyid ]; then
		git config --global user.signingkey $git_gpgkeyid
		git config --global commit.gpgsign true 
	else
		git config --global commit.gpgsign false
	fi
fi

