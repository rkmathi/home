""" Plugin settings """
" {{{
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=$HOME/.vim/neobundle.vim
endif
call neobundle#rc(expand('$HOME/.vim/bundle'))

NeoBundleLazy 'derekwyatt/vim-sbt', {
  \   'autoload': {
  \     'filetypes': ['sbt'],
  \   },
  \ }
NeoBundleLazy 'derekwyatt/vim-scala', {
  \   'autoload': {
  \     'filetypes': ['scala'],
  \   },
  \ }
NeoBundle 'honza/vim-snippets'
NeoBundleLazy 'jelera/vim-javascript-syntax', {
  \   'autoload': {
  \     'filetypes': ['javascript', 'js'],
  \   },
  \ }
NeoBundle 'LeafCage/yankround.vim'
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
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun' " --> <\>+r
NeoBundleLazy 'vim-ruby/vim-ruby', {
  \   'autoload': {
  \     'filetypes': ['ruby'],
  \   },
  \ }

filetype plugin indent on

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
    \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif

" LeafCage/yankround.vim
let g:yankround_dir = '/tmp/yankround'
let g:yankround_max_history = 20
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" majutsushi/tagbar
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let OSTYPE = system('uname')
if OSTYPE == "Darwin\n"
  let g:tagbar_ctags_bin = '/usr/local/bin/ctags' " --> $ brew install ctags
elseif OSTYPE == "Linux\n"
  let g:tagbar_ctags_bin = '/usr/bin/ctags'
endif
let g:tagbar_indent = 1
let g:tagbar_width = 30
" nathanaelkane/vim-indent-guides
au VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightgrey
au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightyellow
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
" Shougo/neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 0
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_dictionary_filetype_lists = {
  \   'default' : '',
  \   'scala' : $HOME . '/.vim/dict/scala.dict',
  \ }
let g:neocomplcache_min_syntax_length = 3
setlocal omnifunc=syntaxcomplete#Complete
" Shougo/neosnippet
let g:neosnippet#snippets_directory='
  \ $HOME/.vim/bundle/vim-snippets/snippets,
  \ $HOME/.vim/snippets'
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Shougo/unite.vim
let g:unite_enable_start_insert = 0
let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 30
" scrooloose/syntastic
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_signs = 1
"let g:syntastic_javascript_checker = "jshint"
" thinca/vim-quickrun
let g:quickrun_config = {
  \   '_': {
  \     'outputter/buffer/split': ':topleft 10sp',
  \     'outputter/buffer/close_on_empty': 0,
  \     'runner': 'vimproc',
  \     'runner/vimproc/updatetime': 50,
  \   }
  \ }
" }}}

