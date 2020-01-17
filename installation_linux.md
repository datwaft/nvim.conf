# Linux Installation Instructions
**Written by:** datwaft

### Get essentials:
```shell
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
```

### Install _neovim_ to _/usr/local_:
```shell
cd /tmp/
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
```

### _Pip_ install:
```shell
sudo apt-get install python3-pip
python3 -m pip install neovim pynvim
python3 -m pip install jedi pylint
sudo -H python3 -m pip install neovim-remote
sudo apt-get install texlive
sudo apt-get install latexmk
```

### _Ruby_ install:
Note: You cannot use _gem_ with hamachi adapter enabled. 
```shell
sudo apt-get install ruby-full
sudo gem install neovim
```

### _Node_ install:
```shell
sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install nodejs
sudo npm install -g neovim
```

### _Python2_ install:
```shell
sudo apt-get install python-pip
python -m pip install neovim pynvim
```

### Getting _neovim_ configuration:
If you can't enter .config folder try using `sudo chmod` to get permission.
```shell
cd ~/.config/
git clone https://github.com/datwaft/nvim
```
Here please do a `:PlugInstall` and a `:UpdateRemotePlugins`.

### _Git_ configuration:
```shell
git config --global user.name "username"
git config --global user.email "username@mail.com"
git config --global core.editor nvim
ssh-keygen -t rsa -C "username@mail.com"
clip.exe < ~/.ssh/id_rsa.pub
```
Paste your ssh public key into your github account settings.  
Go to your github Account Settings  
Click “SSH Keys” on the left.  
Click “Add SSH Key” on the right.  
Add a label (like “WSL”) and paste the public key into the big text box.  
  
In a terminal/shell, type the following to test it:  
```
ssh -T git@github.com
```
