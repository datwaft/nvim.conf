# ---------------------------------------------------------------------------- #
# ->                   ____                                                 <- #
# ->                  | __ )  __ _ _ __  _ __   ___ _ __                    <- #
# ->                  |  _ \ / _` | '_ \| '_ \ / _ \ '__|                   <- #
# ->                  | |_) | (_| | | | | | | |  __/ |                      <- #
# ->                  |____/ \__,_|_| |_|_| |_|\___|_|                      <- #
# ->                                                                        <- #
# ->              ____                           _                          <- #
# ->             / ___| ___ _ __   ___ _ __ __ _| |_ ___  _ __              <- #
# ->            | |  _ / _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__|             <- #
# ->            | |_| |  __/ | | |  __/ | | (_| | || (_) | |                <- #
# ->             \____|\___|_| |_|\___|_|  \__,_|\__\___/|_|                <- #
# ->                                                                        <- #
# ->                          Created by: datwaft                           <- #
# ---------------------------------------------------------------------------- #

import subprocess
import sys
import argparse

DELIMITER = {
    'c++':    {'left': '/*', 'right': '*/'},
    'python': {'left': '#', 'right': '#'},
    'vim':   {'left': '"', 'right': '"'},
    'lisp':   {'left': ';;', 'right': ';;'},
    'custom':   {'left': '\\ \'', 'right': '\','}
}

def banner_generator(text):
    limit = left + ' ' + '-' * (width - 2 - len(left) - len(right)) + ' ' + right
    try:
        result = subprocess.run(['figlet', '-w', str(width - 6 - len(left) -\
            len(right)), text], stdout=subprocess.PIPE).stdout.decode('utf-8')
    except:
        raise SystemError('figlet must be accessible from $PATH')
    result = result.splitlines()
    banner = limit + '\n'
    for line in result:
        banner += left + ' ->' + line.center(width - 6 - len(left) - len(right)) + '<- ' +\
        right + '\n'
    banner += limit + '\n'
    return banner

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generates a centered banner."
                        "figlet must be accessible from $PATH")
    parser.add_argument('string', metavar='string', type=str,
                        help='the string used to generate the banner')
    parser.add_argument('-w', dest='width', type=int, default=80,
                        help='the width of the banner, defaults to \'80\'')
    parser.add_argument('-l', dest='language', type=str, default='vim', choices=DELIMITER,
                        help='the language for the delimiters, defaults to \'vim\'')
    args = parser.parse_args()
    string = args.string
    width = args.width
    left = DELIMITER[args.language]['left']
    right = DELIMITER[args.language]['right']
    print(banner_generator(string))

