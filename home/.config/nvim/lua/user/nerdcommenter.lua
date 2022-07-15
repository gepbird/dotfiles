require 'user.utils'

vim.g.NERDCreateDefaultMappings = 0
vim.g.NERDCommentEmptyLines = 1

register_maps {
  { 'nv', 'bi', '<Plug>NERDCommenterToggle' },
  { 'nv', 'b<s-i>', '<Plug>NERDCommenterSexy' },
}

