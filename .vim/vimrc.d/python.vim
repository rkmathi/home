""" python.vim """

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
let g:jedi#auto_vim_configuration=0
let g:jedi#completions_enabled=0
let g:neocomplete#force_omni_input_patterns.python='\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

