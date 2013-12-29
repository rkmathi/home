""" Keymap settings """
" {{{
" The prefix key
nnoremap [Tag] <Nop>
nmap     t [Tag]

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

nnoremap <silent> <C-]> g<C-]>
nnoremap <silent> <leader>m :make<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>
nnoremap <silent> <leader>uf :<C-u>Unite buffer<CR>
nnoremap <silent> <leader>ua :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> <leader>ub :<C-u>Unite bookmark<CR>
nnoremap <silent> <leader>um :<C-u>Unite file_mru<CR>
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \ : "\<TAB>"
au FileType unite nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
au FileType unite nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
" }}}

