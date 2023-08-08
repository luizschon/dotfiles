#! /usr/bin/env bash

print_error() {
    local source=$1
    echo -e "\e[31mERROR:\e[0m couldn't link ${source}."
}

print_success() {
    local source=$1
    local target=$2
    echo -e "\e[32mOK:\e[0m linked ${source} to ${target}."
}

create_backup() {
    local source=$1
    echo -e "\e[1;33mINFO:\e[0m creating backup of ${source}."
    mv "$source" "${source}~" 
}

link_files() {
    local source_dir=$1
    local target_dir=$2
    local names=$(ls -A "$source_dir")

    echo -e "\e[1;33mINFO:\e[0m linking to ${target_dir}."
    
    for n in ${names[@]}
    do
        local target="$target_dir/$n"

        # Create backup of file/dir if it's not a symlink
        if [[ -f "$target" || -d "$target" ]]; then
            [[ -L "$target" ]] || create_backup $target
        fi

        # Link file and print error message if return code > 0, otherwise print success message
        ln -sf "$source_dir/$n" "$target"
        [[ $? != 0 ]] && print_error $n || print_success $n $target

        # Remove infinite link loop caused by symlinking dirs that are already linked
        [[ -d "$source_dir/$n/$n" ]] && unlink "$source_dir/$n/$n"
    done
}

curr_user=$(whoami)

# Fix dir declarations to work when logged as root.
# Useful while trying to use the script during the 
# linux installation process
if [[ curr_user == "root" ]]; then
    echo "Running script as ROOT"
    user=$(tail -1 /etc/passwd | awk -F: '{ print $1}')
    config_dir="/home/$user/.config"
    gnupg_dir="/home/$user/.gnupg"
else
    config_dir="$HOME/.config"
    gnupg_dir="$HOME/.gnupg"
fi

base_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

link_files "$base_dir/home"   "$HOME"
link_files "$base_dir/config" "$config_dir"
link_files "$base_dir/gnupg"  "$gnupg_dir"

