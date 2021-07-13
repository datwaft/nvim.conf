# Dependencies installation guide

My *neovim* *dotfiles* require some extra dependencies. Here is the guide about how to install them.

## Lua & LuaRocks

This was extracted from this [link](https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Unix).

```shell
# Development tools for building
sudo apt-get install -y build-essential libreadline-dev
# Installing Lua
mkdir ~/downloads 2> /dev/null; cd ~/downloads
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

## Go

This is needed for [vim-hexokinase](https://github.com/RRethy/vim-hexokinase).

For Go you can use [Go Version Manager](https://github.com/moovweb/gvm).

## Node

For Node you can use [Node Version Manager](https://github.com/nvm-sh/nvm).

## Telescope dependencies

Must have:
- [ripgrep](https://github.com/BurntSushi/ripgrep) (finder)
Optional:
- [bat](https://github.com/sharkdp/bat) (preview)
- [fd](https://github.com/sharkdp/fd) (finder)
