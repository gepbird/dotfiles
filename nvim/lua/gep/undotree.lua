vim.cmd 'let g:undotree_WindowLayout = 2'

require 'gep.utils'.register_maps {
  { 'n', '<space>u', ':UndotreeToggle<cr>' },
}
