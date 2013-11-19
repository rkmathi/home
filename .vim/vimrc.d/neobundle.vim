""" NeoBundle settings """
" {{{
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=$HOME/.vim/neobundle.vim
endif
call neobundle#rc(expand('$HOME/.vim/bundle'))

NeoBundle 'YankRing.vim'
NeoBundle 'derekwyatt/vim-sbt'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'honza/vim-snippets'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'majutsushi/tagbar'   " --> <\>+t
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'    " --> <\>ub, <\>uf, <\>um
NeoBundle 'Shougo/vimproc', {
\   'build' : {
\     'windows': 'make -f make_mingw32.mak',
\     'cygwin':  'make -f make_cygwin.mak',
\     'unix':    'make -f make_unix.mak',
\     'mac':     'make -f make_mac.mak'
\   }
\ }
NeoBundle 'Shougo/vinarise'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun' " --> <\>+r
NeoBundle 'vim-ruby/vim-ruby'

filetype plugin indent on

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
    \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif
" }}}
