#!/usr/bin/env bash
# https://gist.github.com/leosuncin/25bad6ae66c5d513b986


# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up
cd ..
rm -rf fonts

echo "=> powerline installed."
