#!/usr/bin/env python
# -*- coding: utf-8 -*-


from os import getenv

try:
    from setuptools import setup, find_packages
except ImportError:
    from distutils.core import setup

NAME = 'oxmicro-hello-world'
PACKAGE = 'oxmicro_hello_world'

DESCRIPTION = 'Hello World package'
AUTHOR = 'Kevin Short'
AUTHOR_EMAIL = 'kevinshortnh@gmail.com'
URL = 'http://www.oxmicro.com/'

VERSION = '1.2.2'

SCRIPT = '{}={}.{}:{}'.format(NAME, PACKAGE, 'hello', 'main')

setup(
    name=NAME,
    version=VERSION,
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    maintainer=AUTHOR,
    maintainer_email=AUTHOR_EMAIL,
    url=URL,
    description=DESCRIPTION,
    include_package_data=True,
    package_dir={NAME: PACKAGE},
    platforms=(
        'Linux',
        'Mac OS X',
    ),
    classifiers=(
        'Intended Audience :: Developers',
        'Natural Language :: English',
        'Operating System :: POSIX :: Linux',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2.7'
    ),
    entry_points={
        'console_scripts': [
            SCRIPT,
        ],
    },
    packages=find_packages(),
    )
