# Previous Documentation

This is the documentation for before you use this neovim configuration.

## Install Java14

**source:** <https://computingforgeeks.com/how-to-install-java-14-on-ubuntu-debian/>

This is the second method, installing from a PPA repository.

### Installing Java 14

```
sudo apt update
sudo add-apt-repository ppa:linuxuprising/java
sudo apt -y install oracle-java14-installer
sudo apt -y install oracle-java14-set-default
```

### After installation

**Note: If you use my ZSH dotfiles the you don't need do to this.**

We set `$JAVA_HOME` to `/usr/lib/jvm/java-14-oracle` and add `$JAVA_HOME/bin` to `$PATH`.

Add the following snippet to `$HOME/.profile` or `$HOME/.zprofile` depending on your shell.

```shell
export JAVA_HOME=/usr/lib/jvm/java-14-oracle
export PATH=$PATH:$JAVA_HOME/bin
```

## Install Go

Go to <https://golang.org/dl/> and copy the link for Linux. (Our example link is: `https://golang.org/dl/go1.14.6.linux-amd64.tar.gz`).

### Downloading Go

```shell
cd /tmp/
mkdir golang && cd golang
wget https://golang.org/dl/go1.14.6.linux-amd64.tar.gz -O go.tar.gz
```

### Installing Go

Here we extract Go to `/usr.local`, creating a Go tree in `/usr/local/go`

```shell
sudo tar -C /usr/local -xzf go.tar.gz
```

### After installation

**Note: If you use my ZSH dotfiles the you don't need do to this.**

We add `/usr/local/go/bin` to `$PATH`.

Add the following snippet to `$HOME/.profile` or `$HOME/.zprofile` depending on your shell.

```shell
export PATH=$PATH:/usr/local/go/bin
```

## After previous preparation

Here are the instructions you should follow after following the previous instructions.

### 1. Clone the neovim configuration

The folder for neovim configuration is `$HOME/.config/nvim`.

Use the following if you want to clone using SSH:

```shell
git clone git@github.com:datwaft/nvim.git "$HOME/.config/nvim"
```

Use the following if you want to clone using HTTPS:

```shell
git clone https://github.com/datwaft/nvim.git "$HOME/.config/nvim"
```
