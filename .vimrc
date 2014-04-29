set nocompatible
filetype off

""" NeoBundle settings """
if has('vim_starting')
  set runtimepath+=$HOME/.vim/neobundle.vim
endif
call neobundle#rc(expand('$HOME/.vim/bundle'))

"" Essentials ""
NeoBundle     'altercation/vim-colors-solarized'
NeoBundle     'LeafCage/yankround.vim'
NeoBundle     'nathanaelkane/vim-indent-guides'
NeoBundle     'osyo-manga/vim-over'
NeoBundle     'scrooloose/syntastic'
NeoBundle     'Shougo/neocomplcache'
NeoBundle     'Shougo/vimproc', {
\   'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   }
\ }
NeoBundle     'thinca/vim-quickrun'
"" Others ""
NeoBundle     'Shougo/vinarise'


""" Plugin settings """
" check new bundles
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
    \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif

"" ESSENTIALS ""
" LeafCage/yankround.vim
let g:yankround_dir='$HOME/.vim/.yankround'
let g:yankround_max_history=20
" nathanaelkane/vim-indent-guides
au VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=grey
au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightgrey
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
" scrooloose/syntastic
let g:syntastic_auto_loc_list=0
let g:syntastic_mode_map={
\   'mode': 'passive',
\   'active_filetypes': ['c', 'cpp', 'go', 'perl', 'python', 'ruby', 'scala'],
\   'passive_filetypes': ['html', 'xml']
\ }
" Shougo/neocomplcache
let g:acp_enableAtStartup=0
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_dictionary_filetype_lists = {
\   'default' : '',
\   'scala' : $HOME . '/.vim/dict/scala.dict',
\ }
let g:neocomplcache_min_syntax_length=3
" thinca/vim-quickrun
let g:quickrun_config = {}
let g:quickrun_config = {
\   '*': {
\     'outputter/buffer/close_on_empty': 1,
\     'outputter/buffer/split': ':botright 8sp',
\     'runner': 'vimproc',
\     'runner/vimproc/updatetime': 50,
\   }
\ }


""" KEYMAP SETTINGS """
" prefix
nn  [exec]    <Nop>
nm  <leader>  [exec]
xm  <leader>  [exec]

" LeafCage/yankround.vim
nm  <C-p> <Plug>(yankround-prev)
nm  <C-n> <Plug>(yankround-next)
" osyo-manga/vim-over
nn  [exec]s :OverCommandLine<CR>
nn  [exec]S :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" thinca/vim-quickrun
autocmd FileType qf nn <buffer><silent> q :q<CR>:HierClear<CR>
nn  [exec]q <Nop>
nm  <silent> [exec]qr :QuickRun<CR>

" bracket (http://vim-users.jp/2011/04/hack214/)
vn  ( t(
vn  ) t)
vn  ] t]
vn  [ t[
vn  < t<
vn  > t>
ono ( t(
ono ) t)
ono ] t]
ono [ t[
ono < t<
ono > t>

" clear
nn  <C-l>    :nohl<CR><C-L>

" tab
map <silent> <C-t>c :tablast <bar> tabnew<CR>
map <silent> <C-t>x :tabclose<CR>
map <silent> <C-t>n :tabnext<CR>
map <silent> <C-t>p :tabprevious<CR>

" move
nn  <silent> j  gj
nn  <silent> gj j
nn  <silent> k  gk
nn  <silent> gk k
nn  <silent> $  g$
nn  <silent> g$ $
vn  <silent> j  gj
vn  <silent> gj j
vn  <silent> k  gk
vn  <silent> gk k
vn  <silent> $  g$
vn  <silent> g$ $


""" Encoding settings """
set encoding=utf-8
set fileformats=unix,dos,mac
if has('guess_encode')
  set fileencodings=guess
else
  set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2,cp932
  " from http://www.kawaz.jp/pukiwiki/?vim#content_1_7
  if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
  endif
  if has('iconv')
    let s:enc_euc='euc-jp'
    let s:enc_jis='iso-2022-jp'
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms')==#"\xad\xc5\xad\xcb"
      let s:enc_euc='eucjp-ms'
      let s:enc_jis='iso-2022-jp-3'
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213')==#"\xad\xc5\xad\xcb"
      let s:enc_euc='euc-jisx0213'
      let s:enc_jis='iso-2022-jp-3'
    endif
    if &encoding==#'utf-8'
      let s:fileencodings_default=&fileencodings
      let &fileencodings=s:enc_jis .','. s:enc_euc .',cp932'
      let &fileencodings=s:fileencodings_default .','. &fileencodings
      unlet s:fileencodings_default
    else
      let &fileencodings = &fileencodings .','. s:enc_jis
      set fileencodings+=utf-8,ucs-2le,ucs-2
      if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
        set fileencodings+=cp932
        set fileencodings-=euc-jp
        set fileencodings-=euc-jisx0213
        set fileencodings-=eucjp-ms
        let &encoding=s:enc_euc
        let &fileencoding=s:enc_euc
      else
        let &fileencodings=&fileencodings .','. s:enc_euc
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

" augroup for draw underscore (from @tyru's vimrc)
augroup vimrc
  autocmd!
augroup END
command!
\ -bang -nargs=*
\ MyAutocmd
\ autocmd<bang> vimrc <args>
MyAutocmd InsertLeave * setlocal  nocursorline
MyAutocmd InsertEnter * setlocal  cursorline
MyAutocmd InsertLeave * highlight StatusLine ctermfg=black guibg=black
MyAutocmd InsertEnter * highlight StatusLine ctermfg=grey  guibg=black

" backspace
set backspace=indent,eol,start

" backup
set nobackup noswapfile nowritebackup

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


""" Other setting files """
set runtimepath+=$HOME/.vim/vimrc.d/
runtime! userautoload/*.vim

