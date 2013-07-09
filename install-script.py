#!/usr/bin/env python

import os
import subprocess
import sys

CUI_FILES = ('.ctags', '.gitconfig', '.gitignore-rkmathi', '.hgrc', '.tmux',
        '.vim', '.vimrc', '.zsh.d')
GUI_FILES = ('.gvimrc', )
X_FILES   = ('.xmonad', )

def ln_files(fn):
    cmd = "ln -fsv `pwd`/%(_)s $HOME/%(_)s" % {'_':fn}
    subprocess.call(cmd, shell=True)

def install_files(env):
    cated = "[ -f $HOME/.zsh.d/zshrc.%(_)s ] && source $HOME/.zsh.d/zshrc.%(_)s" % {'_':env}
    cmd = 'echo "%(_)s" >> $HOME/.zshrc' % {'_': cated}
    subprocess.call("cp -fv `pwd`/.zshrc $HOME/.zshrc", shell=True)
    subprocess.call(cmd, shell=True)
    for fn in CUI_FILES:
        ln_files(fn)
    if env == 'linux':
        for fn in X_FILES:
            ln_files(fn)
    if env == 'linux' or 'osx':
        for fn in GUI_FILES:
            ln_files(fn)

def install_error():
    sys.exit("Usage: python install-script.py [linux|osx|server]")

def main():
    if len(sys.argv) != 2:
        install_error()
    elif sys.argv[1] == 'linux' or sys.argv[1] == 'l':
        install_files('linux')
    elif sys.argv[1] == 'osx' or sys.argv[1] == 'o':
        install_files('osx')
    elif sys.argv[1] == 'server' or sys.argv[1] == 's':
        install_files('server')
    else:
        install_error()

if __name__ == '__main__':
    main()

