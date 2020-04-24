# ---------------------------------------------------------------------------- #
# ->                            Title Generator                             <- #
# ->                          Created by: datwaft                           <- #
# ---------------------------------------------------------------------------- #

import sys
import argparse

DELIMITER = {
    'c':      {'left': '*',      'right': '*/'},
    'c++':    {'left': '//',      'right': '//'},
    'python': {'left': '#',       'right': '#'},
    'vim':    {'left': '"',       'right': '"'},
    'lisp':   {'left': ';;',      'right': ';;'},
    'custom': {'left': '\\ \'',   'right': '\','},
    'sql':    {'left': 'PROMPT',  'right': ''}
}

def title_generator(word):
    divisor = left + ' ' + divisor_char * (width - 2 - len(left) - len(right))\
            + ' ' + right
    title_line = left + f' {divisor_char}>' + word.center(width - 6 - len(left) -\
            len(right)) + f'<{divisor_char} ' + right
    return divisor + '\n' + title_line + '\n' + divisor + '\n'

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generates a centered title')
    parser.add_argument('string', metavar='string', type=str,
                        help='the string used to generate the title')
    parser.add_argument('-w', dest='width', type=int, default=80,
                        help='the width of the title, defaults to \'80\'')
    parser.add_argument('-l', dest='language', type=str, default='vim', choices=DELIMITER,
                        help='the language for the delimiters, defaults to \'vim\'')
    parser.add_argument('-d', dest='divisor', type=str, default='-',
                        help='the divisor character, defaults to \'-\'')
    args = parser.parse_args()
    string = args.string
    width = args.width
    divisor_char = args.divisor
    language = args.language
    left = DELIMITER[language]['left']
    right = DELIMITER[language]['right']
    print(title_generator(string))

