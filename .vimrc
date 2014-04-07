set nocompatible
filetype off

""" PLUGIN SETTINGS """
if has('vim_starting')
  set runtimepath+=$HOME/.vim/neobundle.vim
endif
call neobundle#rc(expand('$HOME/.vim/bundle'))

NeoBundle 'altercation/vim-colors-solarized'
NeoBundleLazy 'derekwyatt/vim-sbt', {
\   'autoload': { 'filetypes': ['sbt'] }
\ }
NeoBundleLazy 'derekwyatt/vim-scala', {
\   'autoload': { 'filetypes': ['scala'] }
\ }
NeoBundle     'honza/vim-snippets'
NeoBundle     'LeafCage/yankround.vim'
NeoBundle     'majutsushi/tagbar'
NeoBundle     'nathanaelkane/vim-indent-guides'
NeoBundle     'osyo-manga/vim-over'
NeoBundle     'scrooloose/syntastic'
NeoBundleLazy 'Shougo/neocomplcache', {
\   'autoload' : {
\     'insert' : 1
\   }
\ }
NeoBundle     'Shougo/neosnippet'
NeoBundle     'Shougo/neosnippet-snippets'
NeoBundleLazy 'Shougo/unite.vim', {
\   'autoload' : {
\     'commands' : [ "Unite", "UniteWithBufferDir", "UniteWithCurrentDir" ]
\   }
\ }
NeoBundle     'Shougo/vimproc', {
\   'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   }
\ }
NeoBundle 'Shougo/vinarise'
NeoBundle 'thinca/vim-quickrun'

" check new bundles
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
    \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif
" prefix
nn  [exec]    <Nop>
nm  <leader>  [exec]
xm  <leader>  [exec]

" LeafCage/yankround.vim
let g:yankround_dir = '$HOME/.vim/.yankround'
let g:yankround_max_history=20
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" majutsushi/tagbar
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let OSTYPE=system('uname')
if OSTYPE=="Darwin\n"
  let g:tagbar_ctags_bin='/usr/local/bin/ctags' " --> $ brew install ctags
elseif OSTYPE == "Linux\n"
  let g:tagbar_ctags_bin='/usr/bin/ctags'
endif
let g:tagbar_indent=1
let g:tagbar_width=30
nn  <silent> [exec]t :TagbarToggle<CR>
" nathanaelkane/vim-indent-guides
au VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=grey
au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=yellow
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
" osyo-manga/vim-over
nnoremap [exec]s :OverCommandLine<CR>
nnoremap [exec]S :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" scrooloose/syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = {
\   'mode': 'passive',
\   'active_filetypes': ['c', 'cpp', 'python', 'ruby'],
\   'passive_filetypes': []
\ }
" Shougo/neocomplcache
let g:acp_enableAtStartup=0
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=0
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_dictionary_filetype_lists = {
\   'default' : '',
\   'scala' : $HOME . '/.vim/dict/scala.dict',
\ }
let g:neocomplcache_min_syntax_length=3
setlocal omnifunc=syntaxcomplete#Complete
" Shougo/neosnippet
let g:neosnippet#snippets_directory='
\ $HOME/.vim/bundle/vim-snippets/snippets,
\ $HOME/.vim/snippets'
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
im  <C-k> <Plug>(neosnippet_expand_or_jump)
xm  <C-k> <Plug>(neosnippet_expand_target)
im  <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\ : pumvisible() ? "\<C-n>" : "\<TAB>"
" Shougo/unite.vim
if !exists("g:unite_source_menu_menus")
    let g:unite_source_menu_menus = {}
endif
let g:unite_source_menu_menus.startup = {
\ "description" : "startup menu",
\   "command_candidates" : [
\     [ "vimrc",  "edit " . $MYVIMRC ],
\     [ "gvimrc", "edit " . $MYGVIMRC ],
\     [ "unite-file_mru", "Unite file_mru" ],
\     [ "unite-directory_mru", "Unite directory_mru" ],
\   ]
\ }
let g:unite_enable_start_insert=0
let g:unite_enable_split_vertically=1
let g:unite_winwidth=30
let g:unite_source_alias_aliases = {
\   "startup_file_mru" : {
\     "source" : "file_mru",
\   },
\     "startup_directory_mru" : {
\     "source" : "directory_mru",
\   },
\ }
call unite#custom_max_candidates("startup_file_mru", 15)
call unite#custom_max_candidates("startup_directory_mru", 10)
nn  <silent> [exec]uf :<C-u>Unite buffer<CR>
nn  <silent> [exec]ua :<C-u>UniteBookmarkAdd<CR>
nn  <silent> [exec]ub :<C-u>Unite bookmark<CR>
nn  <silent> [exec]um :<C-u>Unite file_mru<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
au FileType unite nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
" thinca/vim-quickrun
let g:quickrun_config = {
\   '_': {
\     'outputter/buffer/split': ':botright 8sp',
\     'outputter/buffer/close_on_empty': 0,
\     'runner': 'vimproc',
\     'runner/vimproc/updatetime': 50,
\   }
\ }


""" ENCODING SETTINGS """
" encoding
set encoding=utf-8
set fileformats=unix,dos,mac
if has('guess_encode')
  set fileencodings=guess
else
  set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2
  " from http://www.kawaz.jp/pukiwiki/?vim#content_1_7
  if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
  endif
  if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'eucjp-ms'
      let s:enc_jis = 'iso-2022-jp-3'
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
      let s:enc_euc = 'euc-jisx0213'
      let s:enc_jis = 'iso-2022-jp-3'
    endif
    if &encoding ==# 'utf-8'
      let s:fileencodings_default = &fileencodings
      let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
      let &fileencodings = s:fileencodings_default .','. &fileencodings
      unlet s:fileencodings_default
    else
      let &fileencodings = &fileencodings .','. s:enc_jis
      set fileencodings+=utf-8,ucs-2le,ucs-2
      if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
        set fileencodings+=cp932
        set fileencodings-=euc-jp
        set fileencodings-=euc-jisx0213
        set fileencodings-=eucjp-ms
        let &encoding = s:enc_euc
        let &fileencoding = s:enc_euc
      else
        let &fileencodings = &fileencodings .','. s:enc_euc
      endif
    endif
    unlet s:enc_euc
    unlet s:enc_jis
  endif
endif


""" INPUT & VIEW SETTINGS """
" syntax
syntax enable
filetype plugin indent on

" augroup init (from @tyru 's vimrc)
augroup vimrc
  autocmd!
augroup END
command!
\ -bang -nargs=*
\ MyAutocmd
\ autocmd<bang> vimrc <args>

" backup
set nobackup noswapfile nowritebackup

" backspace
set backspace=indent,eol,start

" colorscheme
if stridx($TERM, "xterm-256color") >= 0
  set t_Co=256
else
  set t_Co=16
endif
set list listchars=tab:>_,trail:_
"colorscheme peachpuff
set background=light
colorscheme solarized

" hex
set display=uhex

" indent / tabstop
set autoindent expandtab smartindent smarttab
set sw=2 sts=0 ts=2

" draw underscore
MyAutocmd InsertLeave * setlocal  nocursorline
MyAutocmd InsertEnter * setlocal  cursorline
MyAutocmd InsertLeave * highlight StatusLine ctermfg=black guibg=black
MyAutocmd InsertEnter * highlight StatusLine ctermfg=grey  guibg=black

" search
set hlsearch incsearch smartcase wrapscan

" view
set ambw=double
set autoread
set cmdheight=1
set colorcolumn=80
set laststatus=2
set matchtime=1
set mouse=
set number
set ruler
set scrolloff=3
set showcmd
set showmatch
set showmode
set shortmess=a
set title


""" KEYMAP SETTINGS """
" bracket (http://vim-users.jp/2011/04/hack214/)
vn  ( t(
vn  ) t)
vn  ] t]
vn  [ t[
ono ( t(
ono ) t)
ono ] t]
ono [ t[

" tab jump
for n in range(1, 9)
  execute 'nn <silent> t'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
map <silent> <C-t>c :tablast <bar> tabnew<CR>
map <silent> <C-t>x :tabclose<CR>
map <silent> <C-t>n :tabnext<CR>
map <silent> <C-t>p :tabprevious<CR>

" move
nn <silent> j  gj
nn <silent> gj j
nn <silent> k  gk
nn <silent> gk k
nn <silent> $  g$
nn <silent> g$ $
vn <silent> j  gj
vn <silent> gj j
vn <silent> k  gk
vn <silent> gk k
vn <silent> $  g$
vn <silent> g$ $

" misc
nn  <C-l>     :nohl<CR><C-L>

