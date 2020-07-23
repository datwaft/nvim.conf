# Previous Documentation

This is the documentation for before you use this neovim configuration.

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
