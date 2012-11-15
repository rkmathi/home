scriptencoding utf-8

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

Context types
  let g:neobundle#types#git#default_protocol = 'git'
  let g:neobundle#types#hg#default_protocol = 'https'

  It parses github git repos
    ShouldEqual neobundle#config#parse_path(
          \ 'Shougo/neocomplcache-clang.git'),
          \ {'type' : 'git', 'uri' :
          \   g:neobundle#types#git#default_protocol .
          \  '://github.com/Shougo/neocomplcache-clang.git',
          \  'name' : 'neocomplcache-clang'}
    ShouldEqual neobundle#config#parse_path('Shougo/vimshell'),
          \ {'type' : 'git', 'uri' :
          \   g:neobundle#types#git#default_protocol .
          \  '://github.com/Shougo/vimshell.git',
          \  'name' : 'vimshell'}
    ShouldEqual neobundle#config#parse_path('rails.vim'),
          \ {'type' : 'git', 'uri' :
          \ g:neobundle#types#git#default_protocol .
          \ '://github.com/vim-scripts/rails.vim.git',
          \  'name' : 'rails.vim'}
    ShouldEqual neobundle#config#parse_path(
          \ 'git://git.wincent.com/command-t.git'),
          \ {'type' : 'git', 'uri' :
          \  'git://git.wincent.com/command-t.git',
          \  'name' : 'command-t'}
    ShouldEqual neobundle#config#parse_path('vim-scripts/ragtag.vim'),
          \ {'type' : 'git', 'uri' :
          \ g:neobundle#types#git#default_protocol .
          \ '://github.com/vim-scripts/ragtag.vim.git',
          \  'name' : 'ragtag.vim'}
    ShouldEqual neobundle#config#parse_path(
          \ 'https://github.com/vim-scripts/vim-game-of-life'),
          \ {'type' : 'git', 'uri' :
          \ 'https://github.com/vim-scripts/vim-game-of-life.git',
          \  'name' : 'vim-game-of-life'}
    ShouldEqual neobundle#config#parse_path(
          \ 'git@github.com:gmarik/ingretu.git'),
          \ {'type' : 'git', 'uri' :
          \ 'git@github.com:gmarik/ingretu.git',
          \  'name' : 'ingretu'}
    ShouldEqual neobundle#config#parse_path(
          \ 'gh:gmarik/snipmate.vim.git'),
          \ {'type' : 'git', 'uri' :
          \ g:neobundle#types#git#default_protocol .
          \ '://github.com/gmarik/snipmate.vim.git',
          \  'name' : 'snipmate.vim'}
    ShouldEqual neobundle#config#parse_path(
          \ 'github:mattn/gist-vim.git'),
          \ {'type' : 'git', 'uri' :
          \ g:neobundle#types#git#default_protocol .
          \ '://github.com/mattn/gist-vim.git',
          \  'name' : 'gist-vim'}
    ShouldEqual neobundle#config#parse_path(
          \ 'git@github.com:Shougo/neocomplcache.git'),
          \ {'type' : 'git', 'uri' :
          \ 'git@github.com:Shougo/neocomplcache.git',
          \  'name' : 'neocomplcache'}
  End

  It parse svn repos
    ShouldEqual neobundle#config#parse_path(
          \ 'http://svn.macports.org/repository/macports/contrib/mpvim/'),
          \ {'type' : 'svn', 'uri' :
          \  'http://svn.macports.org/repository/macports/contrib/mpvim/',
          \  'name' : 'mpvim'}
  End

  It parses bitbucket hg repos
    ShouldEqual neobundle#config#parse_path(
          \ 'https://bitbucket.org/ns9tks/vim-fuzzyfinder'),
          \ {'type' : 'hg', 'uri' :
          \  'https://bitbucket.org/ns9tks/vim-fuzzyfinder',
          \  'name' : 'vim-fuzzyfinder'}
    ShouldEqual neobundle#config#parse_path(
          \ 'bitbucket://bitbucket.org/ns9tks/vim-fuzzyfinder'),
          \ {'type' : 'hg', 'uri' :
          \  g:neobundle#types#hg#default_protocol.
          \  '://bitbucket.org/ns9tks/vim-fuzzyfinder',
          \  'name' : 'vim-fuzzyfinder'}
    ShouldEqual neobundle#config#parse_path(
          \ 'bitbucket:ns9tks/vim-fuzzyfinder'),
          \ {'type' : 'hg', 'uri' :
          \  g:neobundle#types#hg#default_protocol.
          \  '://bitbucket.org/ns9tks/vim-fuzzyfinder',
          \  'name' : 'vim-fuzzyfinder'}
    ShouldEqual neobundle#config#parse_path(
          \ 'ns9tks/vim-fuzzyfinder', {'site': 'bitbucket'}),
          \ {'type' : 'hg', 'uri' :
          \  g:neobundle#types#hg#default_protocol.
          \  '://bitbucket.org/ns9tks/vim-fuzzyfinder',
          \  'name' : 'vim-fuzzyfinder'}

    let bundle = neobundle#config#init_bundle(
          \ 'git://github.com/Shougo/neobundle.vim.git',
          \ [{ 'type' : 'hg'}])
    ShouldEqual bundle.name, 'neobundle.vim'
    ShouldEqual bundle.type, 'hg'
    ShouldEqual bundle.uri, g:neobundle#types#git#default_protocol.
          \ '://github.com/Shougo/neobundle.vim.git'
  End

  It parses bitbucket git repos
    ShouldEqual neobundle#config#parse_path(
          \ 'https://bitbucket.org/kh3phr3n/vim-qt-syntax.git'),
          \ {'type' : 'git', 'uri' :
          \  'https://bitbucket.org/kh3phr3n/vim-qt-syntax.git',
          \  'name' : 'vim-qt-syntax'}
    ShouldEqual neobundle#config#parse_path(
          \ 'git://bitbucket.org/kh3phr3n/vim-qt-syntax.git'),
          \ {'type' : 'git', 'uri' :
          \  'git://bitbucket.org/kh3phr3n/vim-qt-syntax.git',
          \  'name' : 'vim-qt-syntax'}
    ShouldEqual neobundle#config#parse_path(
          \ 'bitbucket:kh3phr3n/vim-qt-syntax.git'),
          \ {'type' : 'git', 'uri' :
          \  g:neobundle#types#git#default_protocol.
          \  '://bitbucket.org/kh3phr3n/vim-qt-syntax.git',
          \  'name' : 'vim-qt-syntax'}
  End

  It parses raw repos
    let bundle = neobundle#config#init_bundle(
          \ 'https://raw.github.com/m2ym/rsense/master/etc/rsense.vim',
          \ [{ 'script_type' : 'plugin'}])
    ShouldEqual bundle.name, 'rsense.vim'
    ShouldEqual bundle.type, 'raw'
    ShouldEqual bundle.uri,
          \ 'https://raw.github.com/m2ym/rsense/master/etc/rsense.vim'
  End

  It parses default options.
    let g:neobundle#default_options =
          \ { 'rev' : {'type__update_style' : 'current'} }
    let bundle = neobundle#config#init_bundle(
          \ 'Shoug/neocomplcache', ['', 'rev', {}])
    ShouldEqual bundle.type__update_style, 'current'
  End

  It parses ssh protocol.
    let bundle = neobundle#config#init_bundle(
          \ 'accountname/reponame', [{
          \ 'site' : 'github', 'type' : 'git', 'type__protocol' : 'ssh' }])
    ShouldEqual bundle.uri, 'git@github.com:accountname/reponame.git'

    let bundle = neobundle#config#init_bundle(
          \ 'accountname/reponame', [{
          \ 'site' : 'bitbucket', 'type' : 'hg', 'type__protocol' : 'ssh' }])
    ShouldEqual bundle.uri, 'ssh://hg@bitbucket.org/accountname/reponame'

    let bundle = neobundle#config#init_bundle(
          \ 'accountname/reponame.git', [{
          \ 'site' : 'bitbucket', 'type' : 'git', 'type__protocol' : 'ssh' }])
    ShouldEqual bundle.uri, 'git@bitbucket.org:accountname/reponame.git'
  End
End

Fin

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}

" vim:foldmethod=marker:fen:
