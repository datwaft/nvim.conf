# NeoVim configuration file

**Written by:** datwaft
## FAQ

### Wanna generate the titles?
You can generate the titles with this script, it's marvelous:
```python
MAXIMUM_WIDTH = 80
def title_generator(word):
    divisor = '" ' + '-' * (MAXIMUM_WIDTH - 4) + ' "'
    pad = ' ' * ((MAXIMUM_WIDTH - 8 - len(word))//2)
    title_line = '" ->' + pad + word + pad + (' ' if len(word) % 2 == 1 else '') + '<- "'
    return divisor + '\n' + title_line + '\n' + divisor + '\n'
```
Because this script is already included inside this repository, you can use `:.! python3 title_generator.py "Title"` to input the title
into the current line. Marvelous, isn't it!

### Where can you find Cascadia Code font patched?
Here [adam7/delugia-code](https://github.com/adam7/delugia-code/releases) :D.

### Coc extensions to install:
- coc-highlight
- coc-marketplace
- coc-python
- coc-snippets
- coc-css
- coc-html
- coc-tsserver
- coc-tslint-plugin
- coc-spell-checker
