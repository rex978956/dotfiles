#!/usr/bin/env bash
# https://gist.github.com/leosuncin/25bad6ae66c5d513b986


git clone https://github.com/powerline/fonts.git --depth=1 /tmp/fonts
bash /tmp/fonts/install.sh
rm -rf /tmp/fonts/install.sh

echo "=> powerline installed."
