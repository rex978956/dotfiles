wget https://github.com/sharkdp/bat/releases/download/v0.20.0/bat_0.20.0_amd64.deb -O /tmp/bat_install.deb

dpkg -i /tmp/bat_install.deb

rm /tmp/bat_install.deb

if ( command -v bat > /dev/null 2>&1 ); then
    echo "=> $(bat -V) installed."
fi