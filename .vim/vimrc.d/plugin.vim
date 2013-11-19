""" Plugin settings """
" {{{
" YankRing.vim
let g:yankring_clipboard_monitor = 1
let g:yankring_history_dir = '$HOME/.vim'
let g:yankring_history_file = '.yankring_history'
let g:yankring_ignore_duplicate = 0
let g:yankring_max_history = 10
" majutsushi/tagbar
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let OSTYPE = system('uname')
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
"let g:syntastic_javascript_checker = "jshint"
" thinca/vim-quickrun
let g:quickrun_config = {
\  '_': {
\    'outputter/buffer/split': ':topleft 10sp',
\    'outputter/buffer/close_on_empty': 0,
\    'runner': 'vimproc',
\    'runner/vimproc/updatetime': 50,
\  }
\}
" }}}

