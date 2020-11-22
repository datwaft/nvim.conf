# Dependencies installation guide

My *neovim* *dotfiles* require some extra dependencies. Here is the guide about how to install them.

## LuaRocks

This was extracted from this [link](https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Unix).

```shell
# Development tools for building
sudo apt-get install -y build-essential libreadline-dev
# Installing Lua
mkdir ~/downloads; cd ~/downloads
curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
tar -zxf lua-5.3.5.tar.gz && cd lua-5.3.5
make linux test
sudo make install
# Installing LuaRocks
cd ..
wget https://luarocks.org/releases/luarocks-3.3.1.tar.gz
tar zxpf luarocks-3.3.1.tar.gz && cd luarocks-3.3.1
./configure --with-lua-include=/usr/local/include
make
sudo make install
```

## lua-lsp

```shell
sudo luarocks install --server=http://luarocks.org/dev lua-lsp
sudo luarocks install luacheck
sudo luarocks install lua-cjson
sudo luarocks install lcf
```

## Go

Go to <https://golang.org/dl/> and copy the link for Linux. (Our example link is: `https://golang.org/dl/go1.14.6.linux-amd64.tar.gz`).

```shell
mkdir ~/downloads; cd ~/downloads
wget https://golang.org/dl/go1.14.6.linux-amd64.tar.gz -O go.tar.gz
# Extract Go to /usr/local
sudo tar -C /usr/local -xzf go.tar.gz
```

### After installation

**Note: If you use my ZSH dotfiles the you don't need do to this.**

We add `/usr/local/go/bin` to `$PATH`.

Add the following snippet to `$HOME/.profile` or `$HOME/.zprofile` depending on your shell.

```shell
export PATH=$PATH:/usr/local/go/bin
```

## Node

This is required for _coc.nvim_:

```shell
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
# Install node
nvm install node
# Install node neovim package
npm install -g neovim
```
