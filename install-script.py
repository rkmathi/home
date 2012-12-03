#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess
import sys

cuis = ('.gitconfig', '.gitignore-rkmathi', '.hgrc', '.tmux', 'vimrc',
        '.vim', '.zsh')
guis = ('.gvimrc', '.xmonad')

def rm_ln(filename):
    cmd = "rm -rf ~/%(_)s && ln -s `pwd`/%(_)s ~/%(_)s" % {'_':filename}
    subprocess.call(cmd, shell=True)

def rm_cp(filename):
    cmd = "rm -rf ~/%(_)s && cp `pwd`/%(_)s ~/%(_)s" % {'_':filename}
    subprocess.call(cmd, shell=True)

def install_cui():
    for fn in cuis:
        rm_ln(fn)

def install_gui():
    for fn in guis:
        rm_ln(fn)

def install_zshrc(env):
    cated = "[ -f ~/.zsh/zshrc.%(_)s ] && source ~/.zsh/zshrc.%(_)s" % {'_':env}
    cmd = 'echo "%(_)s" >> ~/.zshrc' % {'_': cated}
    rm_cp('.zshrc')
    subprocess.call(cmd, shell=True)

def install_error():
    sys.exit("Usage: python install-script.py [linux|osx|server]")

def main():
    if len(sys.argv) != 2:
        install_error()
    elif sys.argv[1] == 'linux' or sys.argv[1] == 'l':
        install_cui()
        install_gui()
        install_zshrc('linux')
    elif sys.argv[1] == 'osx' or sys.argv[1] == 'o':
        install_cui()
        install_gui()
        install_zshrc('osx')
    elif sys.argv[1] == 'server' or sys.argv[1] == 's':
        install_cui()
        install_zshrc('server')
    else:
        install_error()

if __name__ == '__main__':
    main()

