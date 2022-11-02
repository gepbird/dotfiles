require 'user.utils'.register_maps {
  { 'nxo', '<s-h>', '5h' },
  { 'nxo', '<s-j>', '5j' },
  { 'nxo', '<s-k>', '5k' },
  { 'nxo', '<s-l>', '5l' },

  { 'nxo', '<c-h>', '0', { unmap = true } },
  { 'nxo', '<c-j>', '}', { unmap = true } },
  { 'nxo', '<c-k>', '{', { unmap = true } },
  { 'nxo', '<c-l>', '$', { unmap = true } },

  { 'nxi', '<a-h>', '<c-w>h' },
  { 'nxi', '<a-j>', '<c-w>j' },
  { 'nxi', '<a-k>', '<c-w>k' },
  { 'nxi', '<a-l>', '<c-w>l' },

  { 'i', '<c-h>', '<left>' },
  { 'i', '<c-j>', '<down>' },
  { 'i', '<c-k>', '<up>' },
  { 'i', '<c-l>', '<right>' },

  { 'i', '<a-h>', '<bs>' },
  { 'i', '<a-l>', '<del>' },

  { 'n', '<space>h', ':split<cr>' },
  { 'n', '<space>v', ':vsplit<cr>' },

  { 'nxo', 'e', '/', { unmap = true } },
  { 'nxo', '<s-e>', '?', { unmap = true } },
  { 'n', '<c-e>', ':nohlsearch<cr>' },

  { 'nxo', 'b', '%', { unmap = true } },

  { 'x', '<', '<gv' },
  { 'x', '>', '>gv' },
  { 'n', '>', '>>' },
  { 'n', '<', '<<' },

  { 'n', '<c-up>', ':resize +2<cr>' },
  { 'n', '<c-down>', ':resize -2<cr>' },
  { 'n', '<c-left>', ':vertical resize -2<cr>' },
  { 'n', '<c-right>', ':vertical resize +2<cr>' },

  { 'n', '<s-y>', 'yy', { unmap = true } },
  { 'n', '<s-c>', 'cc', { unmap = true } },
  { 'n', '<s-d>', 'dd', { unmap = true } },

  { 'n', '<space>q', ':q<cr>' },
  { 'n', '<space><s-q>', ':quitall!<cr>' },
  { 'n', '<space>w', ':w<cr>' },
  { 'n', '<space>W', ':wq<cr>' },

  { 'n', '<space><s-m>', ':messages<cr>' },
  { 'n', '<space>n', function() print(vim.fn.expand '%') end },
  { 'n', '<space><s-n>', function() print(vim.bo.filetype) end },
  { 'n', '<a-q>', 'q' },
  { 'n', '<space><s-r>', ':w<cr>:e<cr>' },

  { 'n', '<s-u>', '<c-r>', { unmap = true } },
  { 'n', 'z', 'i<cr><esc>' },
  { 'n', '<s-z>', '<s-j>' },
  { 'nxi', '<a-f>', 'mfgg=G`f' },

  { 'n', ',', 'mz$a,<esc>`z' },
  { 'n', ';', 'mz$a;<esc>`z' },
  { 'n', 'w', 'ciw' },

  { 'n', '<c-r>', ':lua reload_config()<cr>' },
  { 'n', '<a-r>', ':e $MYVIMRC<cr>' },

  { 'n', '<tab>', ':bnex<cr>' },
  { 'n', '<s-tab>', ':bprevious<cr>' },
  { 'n', '<c-n>', ':enew<cr>' },
}
