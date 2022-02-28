#!/usr/bin/env bash
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#

SCRIPT=$(readlink -f "$0")
ScriptLocation=$(dirname "$SCRIPT")

function run_scripts()
{
    array=($(ls $ScriptLocation))
    for item in ${array[@]}; do
        if [ "$item" != "setup.sh" ]; then
            echo "Running $item"
            $ScriptLocation/$item
            echo "Done $item"
        fi
    done
}


initial

mkdir $HOME/tools

run_scripts


echo_success "Setup Done!"
echo_warning "But maybe you need to reboot your computer."
echo -e "\e[1;33mreboot now? (y/N): \e[0m\c"

if [[ $REPLY =~ ^[Yy]$ ]]
then
    reboot
fi
