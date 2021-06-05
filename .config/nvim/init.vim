""" INITIAL SETTING
if &compatible | set nocompatible | endif

let s:dein_dir = expand('~/.config/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone --depth 1 https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  let s:toml = '~/.config/nvim/dein.toml'
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml)
  call dein#end()
  " Comment out here when debug
  "call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
scriptencoding utf-8


""" KEYMAP SETTING
" prefix
nnoremap <C-w>o     <Nop>
nnoremap <C-w><C-o> <Nop>
nnoremap Q          <Nop>
nnoremap ZZ         <Nop>
nnoremap ZQ         <Nop>
nnoremap <C-l>      :noh<CR><C-l>
" bracket
nnoremap  ( t(
nnoremap  ) t)
nnoremap  ] t]
nnoremap  [ t[
" move
nnoremap  <silent> j  gj
nnoremap  <silent> gj j
nnoremap  <silent> k  gk
nnoremap  <silent> gk k
nnoremap  <silent> $  g$
nnoremap  <silent> g$ $
" search
vnoremap * "zy:let @/ = @z<CR>n

" prabirshrestha/vim-lsp (<Space>-l-*)
nnoremap [lsp]     <Nop>
nmap     <Space>l  [lsp]
if empty(globpath(&rtp, 'autoload/lsp.vim'))
  finish
endif
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <silent> [lsp]d <plug>(lsp-definition)
  nmap <silent> [lsp]h <plug>(lsp-hover)
  nmap <silent> [lsp]i <plug>(lsp-implementation)
  nmap <silent> [lsp]p <plug>(lsp-peek-definition)
  nmap <silent> [lsp]t <plug>(lsp-type-definition)
  nmap <silent> [lsp]r <plug>(lsp-references)
endfunction
augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" tab (<Space>-t-*)
nnoremap [tab]    <Nop>
nmap     <Space>t [tab]
nmap <silent> [tab]n  :tabnext<CR>
nmap <silent> [tab]p  :tabprevious<CR>
nmap <silent> [tab]t  :tablast <bar> tabnew<CR>
nmap <silent> [tab]x  :tabclose<CR>

" Shougo/denite.nvim (<Space>-<Space>-*)
nnoremap  [denite]       <Nop>
nmap      <Space><Space> [denite]
nmap <silent> [denite]b :<C-u>Denite -split=floating buffer<CR>
nmap <silent> [denite]f :<C-u>Denite -split=floating file/rec<CR>
nmap <silent> [denite]g :<C-u>Denite -split=floating grep<CR>
nmap <silent> [denite]l :<C-u>Denite -split=floating line<CR>
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
  nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q       denite#do_map('quit')
  nnoremap <silent><buffer><expr> \|       denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> -       denite#do_map('do_action', 'split')
endfunction
let s:ignore_globs = ['.git', '.svn', 'node_modules']
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', s:ignore_globs)
let s:denite_win_width_percent = 0.8
let s:denite_win_height_percent = 0.6
call denite#custom#option('default', {
  \ 'split': 'floating',
  \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
  \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
  \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
  \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
  \ })
call denite#custom#source('file/rec', 'matchers', ['matcher/substring'])
call denite#custom#var('file/rec', 'command', ['ag', '--follow']
  \ + map(deepcopy(s:ignore_globs), { k, v -> '--ignore=' . v })
  \ + ['--nocolor', '--nogroup', '-g', ''])


""" MISC SETTING
set ambw=double
set autoindent expandtab smartindent smarttab sw=2 sts=0 ts=2
set autoread
set backspace=indent,eol,start
set display=uhex
set cmdheight=1
set colorcolumn=80
set fileformats=unix,dos,mac
set foldenable
set foldlevel=99
set foldmethod=syntax
set foldnestmax=3
set hlsearch incsearch smartcase wrapscan
set lazyredraw
set list listchars=tab:»_,trail:_
set matchtime=1
set mouse=
set nobackup noswapfile nowritebackup
set novisualbell
set number
set previewheight=15
set ruler
set showcmd
set showmatch
set showmode
set shortmess=a
set tags=tags;
set title
set wildignorecase
set wildmode=list:full
" colorscheme
if stridx($TERM, "xterm-256color") >= 0
  set t_Co=256
else
  set t_Co=16
endif
set background=light
colorscheme solarized
"colorscheme peachpuff
" remember last opened line
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd BufReadPost * delmarks!
" statusline
set laststatus=2
set statusline=%<     " too long
set statusline+=(%n)  " buffer number
set statusline+=%m    " edited flag
set statusline+=%r    " read only flag
set statusline+=%h    " help buffer flag
set statusline+=%w    " preview window flag
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'} " fenc & ff
set statusline+=%y    " filetype
set statusline+=\ %f  " file path
set statusline+=%=    " separator
set statusline+=%1l,%c/%L%4p%%              " line
set statusline+=\ %{fugitive#statusline()}  " git


""" FILETYPE SETTING
autocmd BufNewFile,BufRead *.erb  set filetype=eruby.html
autocmd BufNewFile,BufRead *.go   set filetype=go
autocmd BufNewFile,BufRead *.haml set filetype=haml.html
autocmd BufNewFile,BufRead *.md   set filetype=markdown
autocmd BufNewFile,BufRead *.rs   set filetype=rust
autocmd FileType go       setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType markdown setlocal             tabstop=4 shiftwidth=4
