# Linux Installation Instructions
**Written by:** David Guevara (datwaft)

## Get essentials
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
```

## Install neovim to /usr/local
```
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..
rm -r -f -d neovim
```

## pip install
```
sudo apt-get install python3-pip
python3 -m pip install eyed3
python3 -m pip install neovim pynvim
python3 -m pip install jedi
sudo -H python3 -m pip install neovim-remote
sudo apt-get install texlive
sudo apt-get install latexmk
```

## ruby install
```
sudo apt-get install ruby-full
sudo gem install neovim
```

## node install
```
sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install nodejs
sudo npm install -g neovim
```

## python2 install
```
sudo apt-get install python-pip
python -m pip install neovim pynvim
```

## getting neovim configuration
```
cd .config/
git clone https://github.com/datwaft/nvim
```
here please do a :PlugInstall and a :UpdateRemotePlugins
