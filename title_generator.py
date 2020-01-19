# ---------------------------------------------------------------------------- #
# ->                            Title Generator                             <- #
# ---------------------------------------------------------------------------- #

import sys
import argparse

DELIMITER = {
    'c':    {'left': '/*', 'right': '*/'},
    'c++':    {'left': '//', 'right': '//'},
    'python': {'left': '#', 'right': '#'},
    'vim':   {'left': '"', 'right': '"'},
    'lisp':   {'left': ';;', 'right': ';;'},
    'custom':   {'left': '\\ \'', 'right': '\','}
}

def title_generator(word):
    divisor = left + ' ' + '-' * (width - 2 - len(left) - len(right))\
            + ' ' + right
    title_line = left + ' ->' + word.center(width - 6 - len(left) -\
            len(right)) + '<- ' + right
    return divisor + '\n' + title_line + '\n' + divisor + '\n'

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generates a centered title')
    parser.add_argument('string', metavar='string', type=str,
                        help='the string used to generate the title')
    parser.add_argument('-w', dest='width', type=int, default=80,
                        help='the width of the title, defaults to \'80\'')
    parser.add_argument('-l', dest='language', type=str, default='vim', choices=DELIMITER,
                        help='the language for the delimiters, defaults to \'vim\'')
    args = parser.parse_args()
    string = args.string
    width = args.width
    left = DELIMITER[args.language]['left']
    right = DELIMITER[args.language]['right']
    print(title_generator(string))

