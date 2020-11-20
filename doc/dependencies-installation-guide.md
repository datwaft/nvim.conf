# Dependencies installation guide

My *neovim* *dotfiles* require some extra dependencies. Here is the guide about how to install them.

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
