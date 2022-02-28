#!/usr/bin/env bash
#   Version 
#   Author: Bandit
#   GitHub: github.com/rex978956
#

files=(zshrc)

CurrentUser=$1
HomeDirectory=$2
ScriptLocation=$3  # root folder setup.sh location

function initial()
{
    if [ "$CurrentUser" == "" ] || [ "$HomeDirectory" == "" ] || [ "$ScriptLocation" == "" ]; then
        echo -e "\e[0;31m[Failure] Zsh Setup: No argument passed\e[0m"
        exit 1
    fi
    ScriptLocation="$ScriptLocation/Zshell"
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

# clone some custom plugin
git clone https://github.com/zsh-users/zsh-autosuggestions --depth=1 $ScriptLocation/ohmyzsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git --depth=1 $ScriptLocation/ohmyzsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions --depth=1 $ScriptLocation/ohmyzsh/custom/plugins/zsh-completions


# install themes
cp $ScriptLocation/bandit-wsl.zsh-theme $ScriptLocation/ohmyzsh/custom/themes/bandit-wsl.zsh-theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ScriptLocation/ohmyzsh/custom/themes/powerlevel10k

#switch to zsh
echo "change default shell to zsh"
chsh -s /bin/zsh $CurrentUser

