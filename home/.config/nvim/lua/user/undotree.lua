vim.cmd 'let g:undotree_WindowLayout = 2'

require 'user.utils'.register_maps {
  { 'n', '<space>u', ':UndotreeToggle<cr>' },
}
