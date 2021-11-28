function! myconfig#after() abort

  set tabstop=2
  set shiftwidth=2
  set expandtab

  inoremap jj <esc>

  nnoremap <S-l> e
  nnoremap <S-h> b
  nnoremap <S-j> 5j
  nnoremap <S-k> 5k

  nnoremap <S-u> <C-r>

  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

  nnoremap <S-z> <S-j>

  nnoremap <C-b> :NERDTreeToggle<CR>
  let g:NERDTreeWinPos = "left"

endfunction
