#!/usr/bin/env bash
#   Version 
#   Author: bandit
#   GitHub: github.com/rex978956
#

files=(tmux.conf tmux.conf.local)

CurrentUser=$1
HomeDirectory=$2
ScriptLocation=$3  # root folder setup.sh location

function initial()
{
    if [ "$CurrentUser" == "" ] || [ "$HomeDirectory" == "" ] || [ "$ScriptLocation" == "" ]; then
        echo -e "\e[0;31m[Failure] Tmux Setup: No argument passed\e[0m"
        exit 1
    fi
    ScriptLocation="$ScriptLocation/Tmux"
}

function install_file()
{
    dst="$HomeDirectory/.$1"
    if [ -f $dst ] || [ -d $dst ]; then
        echo "File conflict: $dst"
    else
        src="$ScriptLocation/$1"
        echo "Link $src to $dst"
        ln -s $src $dst
    fi
}

initial

#install files and folders
for file in ${files[@]}; do
    install_file $file
done


