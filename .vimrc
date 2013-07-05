""" Plugins settings """
set nocompatible
filetype off

" NeoBundle
if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle'))
NeoBundle 'YankRing.vim'
NeoBundle 'ZenCoding.vim'       " --> <C-y>+,
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'hil2u/vim-css3-syntax'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'    " --> :ub, :uf, :um
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vinarise'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-quickrun' " --> <\>+r
NeoBundle 'tpope/vim-haml'
NeoBundle 'vim-ruby/vim-ruby'
filetype plugin indent on

" YankRing.vim
let g:yankring_clipboard_monitor = 1
let g:yankring_history_file = '.vim/.yankring_history'
let g:yankring_ignore_duplicate = 0
let g:yankring_max_history = 50
" ZenCoding.vim
let g:user_zen_settings = { 'indentation':' ' }
" kchmck/vim-coffee-script
autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
" majutsushi/tagbar
let g:tagbar_ctags_bin = '/usr/bin/ctags'
nnoremap <silent> <leader>o :TagbarToggle<CR>
" nathanaelkane/vim-indent-guides
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightyellow
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
    \ 'default' : '',
    \ 'scala' : $HOME . '/.vim/dict/scala.dict',
    \ }
let g:neocomplcache_min_syntax_length = 3
setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType css            setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown  setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript     setlocal omnifunc=javascriptcomplete#CompleteJS
" Shougo/unite.vim
nnoremap :ub :<C-u>Unite buffer<CR>
nnoremap :uf :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
nnoremap :um :<C-u>Unite file_mru -buffer-name=file_mru<CR>
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
let g:unite_enable_start_insert = 0
let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 40
" scrooloose/nerdtree
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1
let g:NERDTreeDirArrows = 0
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
set background=light
set colorcolumn=80
colorscheme peachpuff

" Highlight settings
highlight LineNr ctermbg=black ctermfg=yellow
highlight StatusLine ctermfg=black ctermbg=yellow
highlight StatusLineNC ctermfg=darkgrey ctermbg=yellow

" Make settings
autocmd FileType scala :compiler sbt

