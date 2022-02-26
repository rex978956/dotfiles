#!/usr/bin/env bash
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#

# Absolute path to this script, z.B. /home/bandit/dotfiles/install.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/bandit/dotfiles
ScriptLocation=$(dirname "$SCRIPT")

CurrentUser=$USER
HomeDirectory=$HOME

source ./Script/check_distribution.sh
echo "your distribution is $distribution $distribution_version"

softwares=(git zsh vim tmux curl exuberant-ctags ack-grep autojump python3-pip gcc gdb fonts-powerline)

subfolders=(Git Tmux Vim Zshell Misc)

function initial()
{
    if [ "$distribution" == "Ubuntu" ]; then
        permission=$USER
        CurrentUser=$SUDO_USER
        HomeDirectory="/home/$SUDO_USER"
    elif [ "$distribution" == "CentOS Linux" ]; then # Not guaranteed to perform
        permission=$USER
        CurrentUser=$SUDO_USER
        HomeDirectory="/home/$SUDO_USER"
    elif [ "$distribution" == "Kali GNU/Linux" ]; then # Not guaranteed to perform
        permission=$USER
        CurrentUser=$SUDO_USER
        if [ "$SUDO_USER" == "" ]; then
            CurrentUser=$permission
        fi
        HomeDirectory="/home/bandit"
    else
        echo "Your distribution havn't been support yet. exit.."
        exit 1
    fi

    echo "Enter Current Username: ($CurrentUser)"
    read
    if [ "$REPLY" != "" ]; then
        CurrentUser=$REPLY
    fi

    echo "Enter Home Directory: ($HomeDirectory)"
    read
    if [ "$REPLY" != "" ]; then
        HomeDirectory=$REPLY
    fi

    echo "Enter Script Location: ($ScriptLocation)"
    read
    if [ "$REPLY" != "" ]; then
        ScriptLocation=$REPLY
    fi

    echo "========================================================"
    echo "Home Directory: $HomeDirectory"
    echo "Current Username: $CurrentUser"
    echo "Script Location: $ScriptLocation"
    read -p "Are you sure? (y/N)" -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi
}

function install_dotfiles_folder()
{
    if [ -e "$HomeDirectory/dotfiles" ]; then
        echo "dotfiles in $HomeDirectory existed"
    else
        echo "Link $ScriptLocation to $HomeDirectory"
        ln -s $ScriptLocation $HomeDirectory
    fi
}

function check_software()
{
    echo "checking $1..."
    if [ -x "`which $1`" ]; then
        echo "Done."
    else
        echo "$1 is not installed. installing..."
        if [ "$distribution" == "Ubuntu" ]; then
            apt install -y $1
        elif [ "$distribution" == "CentOS Linux" ]; then
            yum -y install $1
        fi
    fi
}

# scipt start

echo ""
echo "  +------------------------------------------------+"
echo "  |                                                |\\"
echo "  |       Bandit's dotfile install script       | \\"
echo "  |                                                | |"
echo "  +------------------------------------------------+ |"
echo "   \\______________________________________________\\|"
echo ""
echo "copy from inndy, thank you Inndy!"
echo "fork from azdkj532, thank you Squirrel!"

initial

# check sudo
if [ $permission != "root" ]; then
    echo -e "\e[1;4;5m[!] Warning: You need to be sudo..., exit.\e[0m"
    exit 1
fi

# check and install softwares
for software in ${softwares[@]}; do
    check_software $software
done

# clone submodule
echo "Cloning submodule..."
git submodule init
git submodule update

install_dotfiles_folder

# run setups
for subfolder in ${subfolders[@]}; do
    $ScriptLocation/$subfolder/setup.sh $CurrentUser $HomeDirectory $ScriptLocation
done

echo "Done!"

# make workplace dir
# echo "create workplace directory"
# $ScriptLocation/Misc/make_my_workplace_dir.sh

