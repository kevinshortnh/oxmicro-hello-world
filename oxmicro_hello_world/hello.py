from pkg_resources import get_distribution
import sys
import os

PACKAGE = os.path.basename(os.getcwd()).replace('_', '-')

__version__ = get_distribution(PACKAGE).version


def main(args=None):
    if args is None:
        args = sys.argv[1:]
    prog = sys.argv[0]
    print('Hello, World! (version: {}) (prog: {}) (args: {})'.
          format(__version__, prog, args))


if __name__ == '__main__':
    main()
