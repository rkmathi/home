""" plugins.vim """

NeoBundleLazy 'davidhalter/jedi-vim', {
\   'autoload': {
\     'filetypes': ['python', 'python3', 'djangohtml'],
\   },
\   'build': {
\     'mac': 'pip install jedi',
\     'unix': 'pip install jedi',
\   },
\ }

autocmd FileType python setlocal omnifunc=jedi#completions
let s:hooks=neobundle#get_hooks('jedi-vim')
function! s:hooks.on_source(bundle)
  let g:jedi#auto_vim_configuration=0
  let g:jedi#popup_select_first=0
  let g:jedi#goto_assignments_command='[exec]G'
  let g:jedi#rename_command='[exec]R'
endfunction


NeoBundleLazy 'vim-ruby/vim-ruby', {
\   'autoload': { 'filetypes': ['ruby'] },
\ }


NeoBundleLazy 'derekwyatt/vim-sbt', {
\   'autoload': { 'filetypes': ['sbt'] }
\ }


NeoBundleLazy 'derekwyatt/vim-scala', {
\   'autoload': { 'filetypes': ['scala'] }
\ }

