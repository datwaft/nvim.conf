# How to add neovim in wsl to context menu

1. Add a new _registry key_ in `Computer\HKEY_CLASSES_ROOT\*\shell\` with the name you want. e.g. _"WSLVim"_.

2. Edit the value of the string with the name `(Default)` inside the _registry key_ you just created. The string is the name you want for the option.

3. Add a new _string value_ named `Icon` and put as the value the path towards the `.ico` you want to use as the icon.

4. Add a new _registry key_ under the one we just create, name it _"command"_.

5. Edit the value of the string with the name `(Default)` inside _"command"_. The string may be one of these values:
  - `%LOCALAPPDATA%\wsltty\bin\mintty.exe --WSL= --configdir="%APPDATA%\wsltty" nvim '%1'` if you use _wsltty_.
  - `bash.exe -c "wslpath '%1' | xargs nvim"` if you want to use the default form.

Information extracted from: [How to add vim context menu entry - stackoverflow](https://stackoverflow.com/questions/51367359/how-to-add-open-in-vim-context-menu-entry-to-edit-text-files-in-windows-from-w).

## Examples

### Main

![image](https://user-images.githubusercontent.com/37723586/83305549-3e577a80-a1be-11ea-9030-13981037159e.png)

### Command

![image](https://user-images.githubusercontent.com/37723586/83305506-23850600-a1be-11ea-84b0-db799c85dca8.png)
