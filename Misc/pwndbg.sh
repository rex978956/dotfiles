#!/usr/bin/env bash
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#   install pwndbg 2022/02/28

cd ~/tools
git clone https://github.com/pwndbg/pwndbg --depth=1
./pwndbg/setup.sh
rm ~/.gdbinit
echo "source ~/tools/pwndbg/gdbinit.py" > ~/.gdbinit