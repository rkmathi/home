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
syntax on
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
nnoremap  <silent> j  gj
nnoremap  <silent> gj j
nnoremap  <silent> k  gk
nnoremap  <silent> gk k
nnoremap  <silent> $  g$
nnoremap  <silent> g$ $
" search
vnoremap * "zy:let @/ = @z<CR>n
" ctags (<Space>-c-*)
nnoremap  [tag]    <Nop>
nmap      <Space>c [tag]
nnoremap  <silent> [tag]]      g]
nnoremap  <silent> [tag]}      <C-w>g}
nnoremap  <silent> [tag]-      <C-w>g]
" tab (<Space>-t-*)
nnoremap  [tab]    <Nop>
nmap      <Space>t [tab]
nnoremap  <silent> [tab]c  :tablast <bar> tabnew<CR>
nnoremap  <silent> [tab]x  :tabclose<CR>
nnoremap  <silent> <S-Tab> :tabnext<CR>
nnoremap  <silent> [tab]n  :tabnext<CR>
nnoremap  <silent> [tab]p  :tabprevious<CR>
" Shougo/neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
xmap <C-k> <Plug>(neosnippet_expand_target)
inoremap <expr><tab> pumvisible() ?
\ "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
" Shougo/unite.vim (<Space>-u-*)
nnoremap  [unite]    <Nop>
nmap      <Space>u   [unite]
au FileType unite nn <silent><buffer><expr><C-k> unite#do_action('split')
au FileType unite nn <silent><buffer><expr><C-l> unite#do_action('vsplit')
nnoremap  <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap  <silent> [unite]b :<C-u>Unite -winheight=12 bookmark<CR>
nnoremap  <silent> [unite]f :<C-u>Unite -winheight=12 file<CR>
nnoremap  <silent> [unite]g :<C-u>Unite grep -buffer-name=search-buffer<CR>
nnoremap  <silent> [unite]m :<C-u>Unite -winheight=12 buffer file_mru<CR>
nnoremap  <silent> [unite]r :<C-u>Unite -winheight=12 -buffer-name=register register<CR>
" thinca/vim-quickrun (<Space>-q-*)
nnoremap  [qrun]     <Nop>
nmap      <Space>q   [qrun]
autocmd FileType qf nn <buffer><silent> q :q<CR>:HierClear<CR>
nnoremap  <silent> [qrun]r :QuickRun<CR>


""" MISC SETTING
set ambw=double
set autoindent expandtab smartindent smarttab sw=2 sts=0 ts=2
set autoread
set backspace=indent,eol,start
set display=uhex
set cmdheight=1
set colorcolumn=80
"set completeopt-=preview
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
"colorscheme solarized
colorscheme peachpuff
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
autocmd BufNewFile,BufRead *.tx   set filetype=xslate.html
autocmd FileType go       setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType markdown setlocal             tabstop=4 shiftwidth=4
