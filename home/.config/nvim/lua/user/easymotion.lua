require 'user.utils'

vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_startofline = 0
vim.g.EasyMotion_smartcase = 1

register_maps {
  { 'n', 'e', '<Plug>(easymotion-sn)', { unmap = '/' } },
  { 'n', '<s-e>', ':nohlsearch<cr>' },
  { 'o', 'e', '<Plug>(easymotion-tn)', { unmap = '?' } },
  { 'nvo', 'n', '<Plug>(easymotion-next)' },
  { 'nvo', 'N', '<Plug>(easymotion-prev)' },
  { 'nvo', 'qh', '<Plug>(easymotion-linebfckward)' },
  { 'nvo', 'qj', '<Plug>(easymotion-j)' },
  { 'nvo', 'qk', '<Plug>(easymotion-k)' },
  { 'nvo', 'ql', '<Plug>(easymotion-lineforward)' },
  { 'nvo', 'qf', '<Plug>(easymotion-bd-f)' },
  { 'n', 'qf', '<Plug>(easymotion-overwin-f)' },
  { 'nvo', 's', '<Plug>(easymotion-bd-f2)' },
  { 'n', 's', '<Plug>(easymotion-overwin-f2)' },
  { 'nvo', 'qw', '<Plug>(easymotion-bd-w)' },
  { 'n', 'qw', '<Plug>(easymotion-overwin-w)' },
}
