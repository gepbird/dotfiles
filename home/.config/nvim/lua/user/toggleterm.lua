require 'user.utils'

require 'toggleterm'.setup {
  size = 15,
  open_mapping = '<c-t>',
  hide_numbers = true,
  shade_terminals = true,
  start_in_insert = true,
  insert_mapping = true,
  persistent_size = true,
  persistent_mode = true,
  direction = 'horizontal',
  close_on_exit = true,
  shell = 'fish',
  float_opts = {
    border = 'curved',
    winblend = 0,
  },
  winbar = {
    enabled = false,
  },
}

register_maps {
  { 't', '<esc>', '<c-\\><c-s-n>', { unmap = true } },
  { 't', '<a-h>', '<c-\\><c-s-n><c-w>h', { unmap = true } },
  { 't', '<a-j>', '<c-\\><c-s-n><c-w>j', { unmap = true } },
  { 't', '<a-k>', '<c-\\><c-s-n><c-w>k', { unmap = true } },
  { 't', '<a-l>', '<c-\\><c-s-n><c-w>l', { unmap = true } },
}
