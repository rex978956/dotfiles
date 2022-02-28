#!/usr/bin/env bash
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#

# colors
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[1;33m'
NC='\e[0m'
NONEWLINE='\c'

function echo_failure()
{
    echo -e "${RED}[Failure] $1${NC}$2"
}

function echo_success()
{
    echo -e "${GREEN}[Success] $1${NC}$2"
}

function echo_warning()
{
    echo -e "${YELLOW}[Warning] $1${NC}$2"
}

function echo_info()
{
    echo -e "[${GREEN}INFO${NC}] $1$2"
}


# Defines
SCRIPT=$(readlink -f "$0")
ScriptLocation=$(dirname "$SCRIPT")
CurrentUser=$USER
HomeDirectory=$HOME

# Checking distribution
source ./Script/check_distribution.sh

softwares=(git python-is-python3 python3-pip zsh vim tmux curl exuberant-ctags ack-grep autojump gcc gdb fonts-powerline nautilus)

subfolders=(Git Tmux Vim Zshell Misc)

function initial()
{
    if [ "$distribution" == "Ubuntu" ]; then
        permission=$USER
        CurrentUser=$SUDO_USER
        HomeDirectory="/home/$SUDO_USER"
    else
        echo_failure "Only supports Ubuntu. exit.."
        exit 1
    fi

    echo_warning "Enter Current Username: " $NONEWLINE
    read -e -i "$CurrentUser"
    if [ "$REPLY" != "" ]; then
        CurrentUser=$REPLY
    fi

    echo_warning "Enter Home Directory: " $NONEWLINE
    read -e -i "$HomeDirectory"
    if [ "$REPLY" != "" ]; then
        HomeDirectory=$REPLY
    fi

    echo_warning "Enter Script Location: " $NONEWLINE
    read -e -i "$ScriptLocation"
    if [ "$REPLY" != "" ]; then
        ScriptLocation=$REPLY
    fi

    echo "========================================================"
    echo_info "Current Username: $CurrentUser"
    echo_info "Home Directory: $HomeDirectory"
    echo_info "Script Location: $ScriptLocation"
    echo -e "${YELLOW}[Warning] Are you sure? (y/N): ${NC}\c"
    read
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi
}

function install_dotfiles_folder()
{
    if [ -e "$HomeDirectory/dotfiles" ]; then
        echo_info "dotfiles in $HomeDirectory existed"
    else
        echo_info "Link $ScriptLocation to $HomeDirectory"
        ln -s $ScriptLocation $HomeDirectory
    fi
}

function check_software()
{
    echo_info "checking $1..."
    if [ -x "`which $1`" ]; then
        echo_info "checking: $1 already exists."
    else
        echo_info "checking: $1 is not installed. installing..."
        apt install -y $1
    fi
}

# scipt start

echo_info " "
echo_info "   +------------------------------------------------+"
echo_info "   |                                                |\\"
echo_info "   |       Bandit's dotfile install script       | \\"
echo_info "   |                                                | |"
echo_info "   +------------------------------------------------+ |"
echo_info "    \\______________________________________________\\|"
echo_info " "
echo_info "Your distribution is ${distribution:?} ${distribution_version:?}"
echo " "

initial

# check sudo
if [ $permission != "root" ]; then
    echo_failure "You need to be sudo..., exit."
    exit 1
fi

# check and install softwares
for software in ${softwares[@]}; do
    check_software $software
done

# install zh_TW.UTF-8
apt install language-pack-zh-hant -y
locale-gen zh_TW.UTF-8
update-locale

# clone submodule
echo_info "Cloning submodule..."
git submodule init
git submodule update


echo_info "Intalling Dotfiles Folder..."
install_dotfiles_folder

# run setups
for subfolder in ${subfolders[@]}; do
    bash $ScriptLocation/$subfolder/setup.sh $CurrentUser $HomeDirectory $ScriptLocation
done

echo_success "Setup Done!"
echo_warning "But maybe you need to restart your computer."

# make workplace dir
# echo "create workplace directory"
# $ScriptLocation/Misc/make_my_workplace_dir.sh

