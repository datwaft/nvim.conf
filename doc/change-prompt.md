# Explication of how I changed the PROMPT

The purpose of this is to explain how to abbreviate `/mnt/d/` with an `D:/`.

## Original Prompt:

This is the prompt that comes by default in _Debian_, the OS I am using for the WSL.

```bash
"\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
```
## New prompt

### Basic prompt

This is the basic string:
```bash
"\u@\H:\w\$"
```

#### Explanation

- `\u`: the username of the current user.
- `\H`: the hostname.
- `\w`: the current working directory with #HOME abbreviated with a `~`.
- `\$`: if the effective UID is **0**, a `#`, otherwise a `$`.

### Abbreviated prompt

Now the idea is to abbreviate `/mnt/d/` with an `D:/`.

Using `$(<command>)` lets us use a command inside the prompt string, like:

```bash
PS1="\u@\H:$(pwd)\$"
```

This lets us have `datwaft@DESKTOP-HI45ITS:/home/datwaft$` as our prompt instead of `datwaft@DESKTOP-HI45ITS:~$`, but it doesnt change when moving in directories.

#### Using SED

One idea is to use SED to apply a regex substitution:

```bash
PROMPT_COMMAND='pwd2=$(sed "s-/mnt/\(\w\)-\u\1:/-g" <<< $PWD)'
PS1='\u@\H:$pwd2\$ '
```

But its not that easy, because that doesn't substitute `/home/$user` with `~`. 

#### Using conditionals

```bash
PROMPT_COMMAND='pwd2=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && echo "~"; (echo $p | grep -Eq /mnt/.) && echo $p|sed "s-/mnt/\(\w\)/\?-\u\1:/-" || echo $p)'
PS1='\u@\H:$pwd2\$ '
```

And there is it, perfect, but it now needs color.

### Colors

```bash
PROMPT_COMMAND='pwd2=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~"; (echo $p | grep -Eq /mnt/.) && echo $p|sed "s-/mnt/\(\w\)/\?-\u\1:/-" || echo $p)'
PS1='\e[1;32m\u@\H\e[m:\e[1;34m$pwd2\e[m\$ '
```

## New prompt for windows

Wanna summarize `C:\Users\david\AppData\Local\Packages\TheDebianProject.DebianGNULinux_76v4gfsz19hv4\LocalState\rootfs` into `//wsl$/`

```bash
PROMPT_COMMAND='pwd2=$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~"; (echo $p | grep -Eq /media/david/A29E3C599E3C27E5/Users/david/AppData/Local/Packages/TheDebianProject.DebianGNULinux_76v4gfsz19hv4/LocalState/rootfs) && echo $p|sed "s:/media/david/A29E3C599E3C27E5/Users/david/AppData/Local/Packages/TheDebianProject.DebianGNULinux_76v4gfsz19hv4/LocalState/rootfs/\?://wsl$/:" || echo $p)'
PS1='\e[1;32m\u@\H\e[m:\e[1;34m$pwd2\e[m\$ '
```
