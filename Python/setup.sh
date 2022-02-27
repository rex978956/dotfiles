#!/usr/bin/env bash
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#   python3.10

CurrentUser=$1
HomeDirectory=$2
ScriptLocation=$3  # root folder setup.sh location

function initial()
{
    if [ "$CurrentUser" == "" ] || [ "$HomeDirectory" == "" ] || [ "$ScriptLocation" == "" ]; then
        echo "[Git Setup] No argument passed"
        exit 1
    fi

    ScriptLocation="$ScriptLocation/Python"
}


apt install software-properties-common -y
add-apt-repository ppa:deadsnakes/ppa -y
apt update
apt install python3.10
apt install python3.10-dev
apt install python3.10-venv

update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2


# function run_scripts()
# {
#     array=($(ls $ScriptLocation))
#     for item in ${array[@]}; do
#         if [ "$item" != "setup.sh" ]; then
#             bash $ScriptLocation/$item
#         fi
#     done
# }


# initial

# run_scripts

# # echo "${array[@]}"
