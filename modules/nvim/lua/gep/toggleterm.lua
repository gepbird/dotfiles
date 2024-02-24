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
  shell = 'zsh',
  float_opts = {
    border = 'curved',
    winblend = 0,
  },
  winbar = {
    enabled = false,
  },
}

require 'gep.utils'.register_maps {
  { 't', '<esc>', '<c-\\><c-s-n>' },
  { 't', '<a-h>', '<c-\\><c-s-n><c-w>h' },
  { 't', '<a-j>', '<c-\\><c-s-n><c-w>j' },
  { 't', '<a-k>', '<c-\\><c-s-n><c-w>k' },
  { 't', '<a-l>', '<c-\\><c-s-n><c-w>l' },
}
