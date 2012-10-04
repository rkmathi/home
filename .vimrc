""" Plugins settings """
set nocompatible
filetype off

" NeoBundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle'))
NeoBundle 'ZenCoding.vim'
NeoBundle 'taglist.vim'
NeoBundle 'pyte'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mitechie/pyflakes-pathogen'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
filetype plugin indent on

" ZenCoding.vim
let g:user_zen_settings = { 'indentation':' ' }
" taglist.vim
:set tags=tags
" kchmck/vim-coffee-script
autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
" nathanaelkane/vim-indent-guides
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=grey
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 2
" Shougo/neocomplcache
imap <C-Space> <C-x><C-o>
setlocal omnifunc=syntaxcomplete#Complete
let g:neocomplcache_enable_at_startup= 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 5
" Shougo/unite.vim
noremap :ub :<C-u>Unite buffer<CR>
noremap :uf :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
noremap :um :<C-u>Unite file_mru -buffer-name=file_mru<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
let g:unite_enable_start_insert = 1
let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 40
" scrooloose/syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2


""" Other Settings """
syntax on
set ambw=double
set autoread
set mouse=a

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
set colorcolumn=80
set background=light
colorscheme peachpuff

" Highlight settings
highlight LineNr ctermbg=lightgrey ctermfg=darkyellow
highlight StatusLine ctermfg=lightgrey ctermbg=darkyellow
highlight StatusLineNC ctermfg=darkgrey ctermbg=yellow

