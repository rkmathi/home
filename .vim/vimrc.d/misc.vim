""" Misc Settings """
" {{{
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
" Language settings
au FileType scala :compiler sbt
au BufRead,BufNewFile *.erb set filetype=eruby.html
au BufRead,BufNewFile *.ejs set filetype=ejs.html
au BufRead,BufNewFile *.md set  filetype=markdown
" }}}

