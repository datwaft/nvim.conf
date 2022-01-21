# Neovim Installation Guide

Welcome to the Neovim installation guide. For further information about how to
install Neovim you can visit the Neovim
[wiki](https://github.com/neovim/neovim/wiki/Installing-Neovim).

## #1. Using Homebrew

This my preferred way of installing Neovim, but requires the use of Homebrew.

**Note:** add `--HEAD` only if you want the nightly version.

```bash
brew install neovim --HEAD
```

## #2. Installing from source (Ubuntu)

I use this way only when I cannot install Homebrew and I don't want to use the
packed version from Github.

This way requires of the following dependencies:

- `git`
- `build-essential`
- `ninja-build`
- `gettext`
- `libtool`
- `libtool-bin`
- `autoconf`
- `automake`
- `cmake`
- `pkg-config`
- `unzip`

To build Neovim follow these steps:

```bash
# Before doing anything navigate to the repository where you want to download Neovim
# Here use the URL of the tag you want
git clone https://github.com/neovim/neovim && cd neovim
# Build neovim (if anything fails you can use sudo, it sometimes fixes the issue)
make CMAKE_BUILD_TYPE=Release
# Install Neovim to /usr/local (to change the installation directory see the wiki)
sudo make install
```

If you want to uninstall Neovim execute the following commands:

```bash
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/
```
