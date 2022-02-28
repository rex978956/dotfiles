#!/usr/bin/env bash
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#   install python3.10.2 to replace python3.8.10

CurrentUser=$1
HomeDirectory=$2
ScriptLocation=$3  # root folder setup.sh location

function initial()
{
    if [ "$CurrentUser" == "" ] || [ "$HomeDirectory" == "" ] || [ "$ScriptLocation" == "" ]; then
        echo -e "\e[0;31m[Failure] Python Setup: No argument passed\e[0m"
        exit 1
    fi

    ScriptLocation="$ScriptLocation/Python"
}


initial

apt-get update -y
apt-get install python3 python3-pip python3-dev -y 
apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
pyenv rehash
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
pyenv install 3.10.2
pyenv global 3.10.2

python3 -m pip install --upgrade pip

git clone https://github.com/pyenv/pyenv.git ~/.pyenv

pkgs=(pwntools pycryptodome requests) 

for pkg in ${pkgs[@]}; do
    python3 -m pip install --upgrade $pkg
done
