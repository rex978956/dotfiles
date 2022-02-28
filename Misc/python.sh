#!/usr/bin/env zsh
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#   install python3.10.2 to replace python3.8.10

sudo apt-get update -y
sudo apt-get install python3 python3-pip python3-dev -y 
sudo apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

git clone https://github.com/pyenv/pyenv.git --depth=1 ~/.pyenv
pyenv rehash
git clone https://github.com/pyenv/pyenv-virtualenv.git --depth=1 $(pyenv root)/plugins/pyenv-virtualenv
pyenv install 3.10.2
pyenv global 3.10.2

source ~/.zshrc

python3 -m pip install --upgrade pip

pkgs=(pwntools pycryptodome requests) 

for pkg in ${pkgs[@]}; do
    python3 -m pip install --upgrade $pkg
done
