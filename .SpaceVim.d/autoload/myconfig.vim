function! myconfig#after() abort

  set tabstop=2
  set shiftwidth=2
  set expandtab

  inoremap jj <esc>

  map <S-l> e
  map <S-h> b
  map <S-j> 5j
  map <S-k> 5k

  map rw dwi 

  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

  map <C-b> :NERDTreeToggle<CR>
  let g:NERDTreeWinPos = "left"

endfunction
