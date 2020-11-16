# Neovim Installation Guide

Welcome to the *neovim* installation guide. For extra information about alternate ways to install *neovim* you can visit this [link](https://github.com/neovim/neovim/wiki/Installing-Neovim).

## 0. Preparation

Please update your *Linux* package manager before installing anything. You can do it like this:

```sh
sudo apt-get update
sudo apt-get upgrade
```

Also, to download neovim you need *git*:

```shell
sudo apt-get install git
```

## 1. Getting build essentials

These are the essentials for building neovim:

<details>
	<summary>Essentials list</summary>
	<ul>
		<li><pre>build-essential</pre></li>
		<li><pre>ninja-build</pre></li>
		<li><pre>gettext</pre></li>
		<li><pre>libtool</pre></li>
		<li><pre>libtool-bin</pre></li>
		<li><pre>autoconf</pre></li>
		<li><pre>automake</pre></li>
		<li><pre>cmake</pre></li>
		<li><pre>pkg-config</pre></li>
		<li><pre>unzip</pre></li>
		<li><pre>mercurial (with Debian)</pre></li>
	</ul>
</details>

You can get these essentials like this:

```shell
sudo apt-get install -y build-essential ninja-build gettext libtool libtool-bin autoconf automake cmake pkg-config unzip
# Only if you use Debian like me.
sudo apt-get install -y mercurial
```

## 2.  Building and installing *neovim* from source

These steps will install neovim to `/usr/local`, if you want to install it in another place you can visit this [link](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source).

```bash
# 1. Go to the directory where you want to download neovim.
mkdir ~/downloads; cd ~/downloads
# 2. Download neovim (this will download the latest bleeding-edge version)
git clone https://github.com/neovim/neovim && cd neovim
# 3. Build neovim
make CMAKE_BUILD_TYPE=Release
# 4. Install neovim to /usr/local
sudo make install
```

### Uninstalling *neovim*

If you want to install neovim – for example, if you want to update neovim – you can do it like this:

```shell
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/
```

