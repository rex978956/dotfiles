#!/usr/bin/env bash
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#

CurrentUser=$1
HomeDirectory=$2
ScriptLocation=$3  # root folder setup.sh location

function initial()
{
    if [ "$CurrentUser" == "" ] || [ "$HomeDirectory" == "" ] || [ "$ScriptLocation" == "" ]; then
        echo "[Git Setup] No argument passed"
        exit 1
    fi

    ScriptLocation="$ScriptLocation/Misc"
}


function run_scripts()
{
    array=($(ls $ScriptLocation))
    for item in ${array[@]}; do
        if [ "$item" != "setup.sh" ]; then
            bash $ScriptLocation/$item
        fi
    done
}


initial

run_scripts

# echo "${array[@]}"
