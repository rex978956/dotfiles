#!/usr/bin/env bash
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#   install pwndbg 2022/02/28

CurrentUser=$1
HomeDirectory=$2
ScriptLocation=$3  # root folder setup.sh location

function initial()
{
    if [ "$CurrentUser" == "" ] || [ "$HomeDirectory" == "" ] || [ "$ScriptLocation" == "" ]; then
        echo -e "\e[0;31m[Failure] Pwndbg Setup: No argument passed\e[0m"
        exit 1
    fi
}

initial

cd $HomeDirectory/tools
git clone https://github.com/pwndbg/pwndbg
bash pwndbg/setup.sh
rm $HomeDirectory/.gdbinit
echo "source $HomeDirectory/tools/pwndbg/gdbinit.py" > .gdbinit