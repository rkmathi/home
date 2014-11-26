""" clojure.vim """
let g:neocomplete#force_overwrite_completefunc=1


NeoBundleLazy 'guns/vim-clojure-static', {
\   'autoload' : { 'filetypes' : ['clojure'] }
\ }

NeoBundleLazy 'kien/rainbow_parentheses.vim', {
\   'autoload' : { 'filetypes' : ['clojure'] }
\ }
augroup VimEnter * RainbowParenthesesToggle
augroup Syntax * RainbowParenthesesLoadRound
augroup Syntax * RainbowParenthesesLoadSquare

" Need `$JAVA_HOME` or `lein repl` before start vim
NeoBundleLazy 'tpope/vim-classpath', {
\   'autoload' : { 'filetypes' : ['clojure'] }
\ }

NeoBundleLazy 'tpope/vim-fireplace', {
\   'autoload' : { 'filetypes' : ['clojure'] }
\ }

