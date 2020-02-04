# My init.vim documentation

**Created by:** _datwaft_  
  
Here is the documentation about every single configuration command in my
_init.vim_ file.  
This _init.vim_ has compatibility with _Windows_ and _Linux_ operative systems;
_MAC OS_ hasn't been tested yet.

## Variables

**g:python_host_prog**: it's where _python 2_ exectuable is.
  - Windows is usually `~/AppData/Local/Programs/Python/Python2#-##/python.exe`.
  - Linux is usually `~/usr/bin/python`.

**g:python3_host_prog**: it's where _python 3_ exectuable is.
  - Windows is usually `~/AppData/Local/Programs/Python/Python3#-##/python.exe`.
  - Linux is usually `~/usr/bin/python3`.

**g:plugins_folder**: it's where plugins are installed using _plugged plugin
manager_.
  - It's usually a folder inside the nvim folder named _plugged_.

## Plugins

### Aesthetic plugins

**mhinz/vim-startify**: a startup screen.
  - **startify_custom_header**: the startup banner.

**morhetz/gruvbox**: a very good colorscheme.
