import sys
import subprocess
import argparse

CHARSET = {
    "DOUBLE": {
        'UL' : '╔',
        'UR' : '╗',
        'DL' : '╚',
        'DR' : '╝',
        'H'  : '═',
        'V'  : '║'
    },
    "SINGLE": {
        'UL' : '┌',
        'UR' : '┐',
        'DL' : '└',
        'DR' : '┘',
        'H'  : '─',
        'V'  : '│'
    },
    "TEXT": {
        'UL' : '+',
        'UR' : '+',
        'DL' : '+',
        'DR' : '+',
        'H'  : '-',
        'V'  : '|'
    },
    "MEGATEXT": {
        'UL' : '=',
        'UR' : '=',
        'DL' : '=',
        'DR' : '=',
        'H'  : '=',
        'V'  : '='
    }
}

PARSE = {
    "d": "DOUBLE",
    "s": "SINGLE",
    "t": "TEXT",
    "mt": "MEGATEXT"
}

DELIMITER = {
    'c':    {'left': '/*', 'right': '*/'},
    'c++':    {'left': '//', 'right': '//'},
    'python': {'left': '#', 'right': '#'},
    'vim':   {'left': '"', 'right': '"'},
    'lisp':   {'left': ';;', 'right': ';;'},
    'sql':   {'left': 'PROMPT', 'right': ''},
    'custom':   {'left': '\\ \'', 'right': '\','}
}

def title_generator(word):
    up = left + ' ' + box['UL'] + box['H'] * (width - 4 - len(left) - len(right)) + box['UR'] + ' ' + right
    down = left + ' ' + box['DL'] + box['H'] * (width - 4 - len(left) - len(right)) + box['DR'] + ' ' + right
    title_line = left + ' ' + box['V'] + word.center(width - 4 - len(left) - len(right)) + box['V'] + ' ' + right
    return up + '\n' + title_line + '\n' + down
def banner_generator(word):
    try:
        result = subprocess.run(['figlet', '-w', str(width - 4 - len(left) -\
            len(right))] + arguments + [word], stdout=subprocess.PIPE).stdout.decode('utf-8')
    except:
        raise SystemError('figlet must be accessible from $PATH')
    result = result.splitlines()
    up = left + ' ' + box['UL'] + box['H'] * (width - 4 - len(left) - len(right)) + box['UR'] + ' ' + right
    down = left + ' ' + box['DL'] + box['H'] * (width - 4 - len(left) - len(right)) + box['DR'] + ' ' + right
    banner = up + '\n'
    for line in result:
        banner += left + ' ' + box['V'] + line.center(width - 4 - len(left) - len(right)) + box['V'] + ' ' + right + '\n'
    return banner + down

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Generates a centered title')
    parser.add_argument('string', metavar='string', type=str,
        help='the string used to generate the title')
    parser.add_argument('-w', dest='width', type=int, default=80,
        help='the width of the title, defaults to \'80\'')
    parser.add_argument('-l', dest='language', type=str, default='vim', choices=DELIMITER,
        help='the language for the delimiters, defaults to \'vim\'')
    parser.add_argument('-a', dest='arguments', type=str, default='',
        help='arguments for figlet, defaults to \'\'')
    parser.add_argument('-b', action='store_true',
        help='the flag means it is going to use figlet for the banner')
    parser.add_argument('-t', dest='type', type=str, default='t', choices=PARSE,
        help='the type of the box, defaults to \'t\'')
    args = parser.parse_args()
    string = args.string
    width = args.width
    box = CHARSET[PARSE[args.type]]
    left = DELIMITER[args.language]['left']
    right = DELIMITER[args.language]['right']
    if len(args.arguments) >= 1:
        arguments = args.arguments.split(' ')
    else:
        arguments = []
    if args.b:
        print(banner_generator(string))
    else:
        print(title_generator(string))

