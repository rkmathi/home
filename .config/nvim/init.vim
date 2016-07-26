""" Initial settings
filetype off
set runtimepath+=$HOME/.config/nvim/neobundle.vim/
call neobundle#begin(expand('$HOME/.config/nvim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'honza/vim-snippets'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'othree/eregex.vim'
NeoBundle 'racer-rust/vim-racer'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {
\   'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   },
\ }
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'tpope/vim-fugitive'

call neobundle#end()
filetype plugin indent on
syntax enable


""" Plugin settings
" LeafCage/yankround.vim
let g:yankround_dir='$HOME/.config/nvim/yankround'
let g:yankround_max_history=20
" nathanaelkane/vim-indent-guides
au VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=grey
au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightgrey
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
" racer-rust/vim-racer
let g:rustfmt_autosave=1
let g:rustfmt_command=('$HOME/.cargo/bin/rustfmt')
set hidden
let g:racer_cmd=expand('$HOME/.cargo/bin/racer')
let $RUST_SRC_PATH=expand('$HOME/.cargo/rustc/src')
" scrooloose/syntastic
let g:syntastic_auto_loc_list=0
let g:syntastic_mode_map={
\   'mode': 'passive',
\   'active_filetypes': [
\     'c', 'cpp', 'go', 'javascript', 'perl', 'python', 'ruby', 'vim',
\   ],
\   'passive_filetypes': [
\     'html', 'xml', 'java', 'scala',
\   ],
\ }
" Shougo/deoplete.nvim
let g:acp_enableAtStartup=0
let g:deoplete#enable_at_startup=1
let g:deoplete#enable_fuzzy_completion=0
let g:deoplete#enable_ignore_case=1
let g:deoplete#enable_smart_case=1
let g:deoplete#sources#buffer#disabled_pattern='\.log\|\.log\.\|\.jax'
" Shougo/neosnippet
let g:neosnippet#snippets_directory='$HOME/.config/nvim/bundle/vim-snippets/snippets,$HOME/.config/nvim/snippets'
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Shougo/unite.vim
let g:unite_enable_start_insert=1
let g:unite_enable_split_vertically=0
if executable('pt')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
" thinca/vim-quickrun
let g:quickrun_config = {}
let g:quickrun_config = {
\   '_': {
\     'outputter/buffer/close_on_empty': 1,
\     'outputter/buffer/split': ':botright 12sp',
\     'runner': 'vimproc',
\     'runner/vimproc/updatetime': 50,
\   },
\ }


""" Encoding settings
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


""" Keymap settings
" prefix
nnoremap <C-w>o   <Nop>
nnoremap Q        <Nop>
nnoremap ZZ       <Nop>
nnoremap ZQ       <Nop>
nnoremap <C-l>    :noh<CR><C-l>
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
nnoremap  <silent> [tag]<C-]>  <C-w>g]
nnoremap  <silent> [tag]}      <C-w>g}
" tab (<Space>-t-*)
nnoremap  [tab]    <Nop>
nmap      <Space>t [tab]
nnoremap  <silent> [tab]c  :tablast <bar> tabnew<CR>
nnoremap  <silent> [tab]x  :tabclose<CR>
nnoremap  <silent> <S-Tab> :tabnext<CR>
nnoremap  <silent> [tab]n  :tabnext<CR>
nnoremap  <silent> [tab]p  :tabprevious<CR>
" number/relativenumber
nnoremap  <F3> :<C-u>setlocal relativenumber!<CR>
" LeafCage/yankround.vim
nmap  <C-p> <Plug>(yankround-prev)
nmap  <C-n> <Plug>(yankround-next)
" osyo-manga/vim-over (<Space>-o-*)
nnoremap  [vimover] <Nop>
nmap      <Space>o  [over]
nnoremap  <silent>  [over]s :OverCommandLine<CR>
nnoremap  <silent>  [over]S :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
" othree/eregex.vim
let g:eregex_default_enable=1
nnoremap / :M/
nnoremap ? :M?
nnoremap ,/ /
nnoremap ,? /
" Shougo/neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\ : pumvisible() ? "\<C-n>" : "\<TAB>"
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


""" Input & View & Misc setting
" syntax
autocmd BufRead,BufNewFile *.erb set filetype=eruby.html
autocmd BufRead,BufNewFile *.haml set filetype=haml.html
autocmd BufRead,BufNewFile *.tx set filetype=xslate.html
" colorscheme
if stridx($TERM, "xterm-256color") >= 0
  set t_Co=256
else
  set t_Co=16
endif
set background=light
colorscheme solarized
"colorscheme peachpuff
" persistent undo
set undodir=$HOME/.config/nvim/.undo
set undofile
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
" Misc settings
set ambw=double
set autoindent expandtab smartindent smarttab sw=2 sts=0 ts=2
set autoread
set backspace=indent,eol,start
set display=uhex
set cmdheight=1
set colorcolumn=80
set completeopt-=preview
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
set previewheight=12
set ruler
set showcmd
set showmatch
set showmode
set shortmess=a
set tags=tags;
set title
set wildignorecase
set wildmode=list:full


""" Other setting files
set runtimepath+=~/.config/nvim/
runtime! nvimrc.d/*.nvim


""" Environment dependent settings
" Python3 settings
let g:python3_host_prog='/usr/local/bin/python3'
