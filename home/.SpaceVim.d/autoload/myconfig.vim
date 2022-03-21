function! myconfig#after() abort

  set tabstop=2
  set shiftwidth=2
  set expandtab

  nnoremap y "+y
  vnoremap y "+y

  inoremap jj <esc>
  map j jzz
  map k kzz

  map <S-l> e
  map <S-h> b
  map <S-j> 5j
  map <S-k> 5k

  nnoremap <S-u> <C-r>

  nnoremap <S-z> <S-j>

  nnoremap c( ci(
  nnoremap c8 ci(
  nnoremap d( di(
  nnoremap d8 di(
  nnoremap y( yi(
  nnoremap y8 yi(

  nnoremap c{ ci{
  nnoremap cb ci{
  nnoremap d{ di{
  nnoremap db di{
  nnoremap y{ yi{
  nnoremap yb yi{

  nnoremap c[ ci[
  nnoremap d[ di[
  nnoremap y[ yi[

  nnoremap c" ci"
  nnoremap c2 ci"
  nnoremap d" di"
  nnoremap d2 di"
  nnoremap y" yi"
  nnoremap y2 yi"

  nnoremap c' ci'
  nnoremap c2 ci'
  nnoremap d' di'
  nnoremap d2 di'
  nnoremap y' yi'
  nnoremap y2 yi'

  nnoremap cp cia
  nnoremap dp daa
  nnoremap yp yaa

  nnoremap ; $a;<esc>
  nnoremap , $a,<esc>

  nnoremap - ;

  nnoremap <C-b> :NERDTreeToggle<CR>
  let g:NERDTreeWinPos = "left"

endfunction
