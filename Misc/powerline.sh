#!/usr/bin/env bash
# https://gist.github.com/leosuncin/25bad6ae66c5d513b986

git clone https://github.com/powerline/fonts.git --depth=1 /tmp/fonts
./tmp/fonts/install.sh
rm -rf /tmp/fonts

echo -e "[\e[0;32mINFO\e[0m] powerline installed."
