function! myconfig#after() abort
  set tabstop=2
  set shiftwidth=2
  set expandtab
  map <C-l> e
  map <C-h> b
  map rw dwi 
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
  map <C-b> :NERDTreeToggle<CR>
  let g:NERDTreeWinPos = "left"
endfunction
