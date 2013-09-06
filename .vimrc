""" Plugins settings """
set nocompatible
filetype off
let OSTYPE = system('uname')

" NeoBundle
if has('vim_starting')
  set runtimepath+=$HOME/.vim/neobundle.vim
endif
call neobundle#rc(expand('$HOME/.vim/bundle'))
NeoBundle 'YankRing.vim'
NeoBundle 'ZenCoding.vim'       " --> <C-y>,
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'honza/vim-snippets'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jsx/jsx.vim'
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
NeoBundle 'slim-template/vim-slim'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'thinca/vim-quickrun' " --> <\>+r
NeoBundle 'tpope/vim-haml'
NeoBundle 'vim-ruby/vim-ruby'
filetype plugin indent on
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
    \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif
" YankRing.vim
let g:yankring_clipboard_monitor = 1
let g:yankring_history_dir = '$HOME/.vim'
let g:yankring_history_file = '.yankring_history'
let g:yankring_ignore_duplicate = 0
let g:yankring_max_history = 10
" ZenCoding.vim
let g:user_zen_settings = { 'indentation': '  ' }
" majutsushi/tagbar
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
if OSTYPE == "Darwin\n"
  let g:tagbar_ctags_bin = '$EPREFIX/usr/bin/ctags'
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
" scrooloose/nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrows = 0
" scrooloose/syntastic
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_signs = 1
let g:syntastic_javascript_checker = "jshint"
" teramako/jscomplete-vim
let g:jscomplete_use = ['dom', 'moz']
" thinca/vim-quickrun
let g:quickrun_config = {
\  '_': {
\    'hook/neko/enable': 1,
\    'hook/neko/wait': 20,
\    'outputter/buffer/split': ':topleft 10sp',
\    'outputter/buffer/close_on_empty': 0,
\    'runner': 'vimproc',
\    'runner/vimproc/updatetime': 50,
\  }
\}


""" Key-Remap Settings """
nnoremap <silent> <C-]> g<C-]>
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
nnoremap <silent> <leader>m :make<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <silent> <leader>uf :<C-u>Unite buffer<CR>
nnoremap <silent> <leader>ua :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> <leader>ub :<C-u>Unite bookmark<CR>
nnoremap <silent> <leader>um :<C-u>Unite file_mru<CR>
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\ : "\<TAB>"
au FileType unite nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')


""" Other Settings """
syntax on
set ambw=double
set autoread
set mouse=
" Backup settings
set nobackup
set noswapfile
set nowritebackup
" Search settings
set smartcase incsearch
set hlsearch
noremap <C-L> :nohl<CR><C-L>
" Outer settings
set number
set showmode
set showcmd
set ruler
set laststatus=2
set cmdheight=1
set shortmess=a
" Tab settings
set smarttab expandtab smartindent autoindent
set shiftwidth=4
set tabstop=4
set softtabstop=0
" Input settings
set showmatch
set matchtime=1
set backspace=2
" Encoding settings
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,euc-jp,iso2022-jp,cp932
set fileformats=unix,dos
" Colorscheme settings
set list
set listchars=tab:>_,trail:_,extends:>,precedes:<
set display=uhex
set background=light
set colorcolumn=80
colorscheme peachpuff
" Highlight settings
highlight LineNr ctermbg=black ctermfg=yellow
highlight StatusLine ctermfg=black ctermbg=yellow
highlight StatusLineNC ctermfg=darkgrey ctermbg=yellow
" Make settings
au FileType scala :compiler sbt

