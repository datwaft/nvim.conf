# Linux Installation Instructions
**Written by:** datwaft

It's recommended to add this folder to `$PATH` like this:
```shell
echo "export PATH=\$PATH:~/.local/bin" >> ~/.profile
source ~/.profile
```

## Custom PROMPT for WSL

The idea is to summarize `/mnt/c/something` into `C:/something`, like Windows.

This is the script to change it temporarily:

```bash
export PROMPT_COMMAND='pwd2=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~"; (echo $p | grep -Eq /mnt/.) && echo $p|sed "s-/mnt/\(\w\)/\?-\u\1:/-" || echo $p)'
export PS1='\[\e[1;32m\]\u@\H\[\e[m\]:\[\e[1;34m\]$pwd2\[\e[m\]\$ '
```

To change it permanently add that to ~/.bashrc and do a `source ~/.bashrc`.

## Make clipboard work with neovim in WSL

### Option1: With X Server

Install [xming](https://sourceforge.net/projects/xming/) on your Windows.

Do this:

```shell
echo "export DISPLAY=:0" >> ~/.profile
source ~/.profile
```

#### Making _xming_ start with the OS

1. Run XLaunch.exe and save the configuration to file `config.xlaunch`.
2. Create a shotcut of XLaunch.exe under _startup directory_ (`shell:startup`).
3. Modify the target field of the shotcut to `"PATH/TO/Xming/XLaunch.exe" -run "PATH/TO/config.xlaunch"`.

**Information from:** http://zhangzhihuiaaa.blogspot.com/2013/09/make-xming-automatically-run-at-startup.html

### Option 2: Without X Server

```shell
echo "export DISPLAY=:0" >> ~/.profile
echo "export PATH=\$PATH:/home/$USER/bin" >> ~/.profile
source ~/.profile
mkdir /home/$USER/bin
```

And create a the file `/home/$USER/bin/xsel` with the following contents:

```bash
#!/bin/bash

# filename: xsel
# make sure this file has executable privledges
# neovim will paste "xsel -o -b"
# neovim will copy using "xsel --nodetach -i -b"

for i in "$@"
do
  case "$i" in
  -o )
    # for paste we will grab contents from powershell.exe
    powershell.exe Get-Clipboard | sed 's/\r$//'
    exit 0
    ;;
  -i )
    # for copy we'll direct stdin to clip.exe
    tee <&0 | clip.exe
    exit 0
  esac
done
```

And use this configuration at the end:

```bash
sudo chmod 777 /home/$USER/bin/xsel
```

### Get essentials:
```shell
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential
sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
```

### Install _neovim_ to _/usr/local_:
```shell
sudo apt-get install -y mercurial
cd /tmp/
git clone https://github.com/neovim/neovim && cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
```

### _Pip_ install:
```shell
sudo apt-get install -y python3-setuptools
sudo apt-get install -y python3-pip
python3 -m pip install wheel
python3 -m pip install pynvim
python3 -m pip install jedi pylint
python3 -m pip install neovim-remote
sudo apt-get install -y texlive
sudo apt-get install -y latexmk
```

### _Ruby_ install:
Note: You cannot use _gem_ with hamachi adapter enabled. 
```shell
sudo apt-get install -y ruby-full
sudo gem install neovim
```

### _Node_ install:
```shell
sudo apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g neovim
sudo npm install -g wsl-open
sudo update-alternatives --install /usr/bin/xdg-open xdg-open /usr/bin/wsl-open 100
```

And for **Bracey** please do:

```shell
cd ~/.config/nvim/plugged/bracey.vim/
npm install --prefix server
```

### _Python2_ install:
```shell
sudo apt-get install python-setuptools
sudo apt-get install -y python-pip
python -m pip install pynvim
```

### Getting _neovim_ configuration:
If you can't enter .config folder try using `sudo chmod 777 ~/.config` to get permission.
```shell
cd ~/.config/
git clone https://github.com/datwaft/nvim
```
Here please do a `:PlugInstall` and a `:UpdateRemotePlugins` when inside *neovim*.

### _Git_ configuration:
```shell
git config --global user.name "datwaft"
git config --global user.email "datwaft@github.com"
git config --global core.editor nvim
ssh-keygen -t rsa -C "datwaft@github.com"
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

### Install _clang_:
```shell
sudo apt-get install -y software-properties-common
sudo apt-get update
sudo apt-get install -y wget
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100
```

### Install _maven_:
```shell
sudo apt-get install -y maven
sudo apt-get install -y default-jre
sudo apt-get install -y default-jdk
echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> ~/.profile
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.profile
source ~/.profile
```

### Install sql-language-server

```shell
sudo npm i -g sql-language-server
```

### Install _tmux_:
```shell
sudo apt-get install -y tmux
```
