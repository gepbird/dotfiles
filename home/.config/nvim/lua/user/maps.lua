require 'user.utils'

register_maps {
  { 'nvo', '<s-h>', '5h' },
  { 'nvo', '<s-j>', '5j' },
  { 'nvo', '<s-k>', '5k' },
  { 'nvo', '<s-l>', '5l' },

  { 'nvo', '<c-h>', '_', { unmap = true } },
  { 'nvo', '<c-j>', '}', { unmap = true } },
  { 'nvo', '<c-k>', '{', { unmap = true } },
  { 'nvo', '<c-l>', '$', { unmap = true } },

  { 'nvi', '<a-h>', '<c-w>h', { insert_to_normal = true } },
  { 'nvi', '<a-j>', '<c-w>j', { insert_to_normal = true } },
  { 'nvi', '<a-k>', '<c-w>k', { insert_to_normal = true } },
  { 'nvi', '<a-l>', '<c-w>l', { insert_to_normal = true } },

  { 'v', '<', '<gv' },
  { 'v', '>', '>gv' },
  { 'n', '>', '>>' },
  { 'n', '<', '<<' },

  { 't', '<a-h>', '<c-\\><c-s-n><c-w>h', { unmap = true } },
  { 't', '<a-j>', '<c-\\><c-s-n><c-w>j', { unmap = true } },
  { 't', '<a-k>', '<c-\\><c-s-n><c-w>k', { unmap = true } },
  { 't', '<a-l>', '<c-\\><c-s-n><c-w>l', { unmap = true } },

  { 'n', '<c-up>', ':resize +2<cr>' },
  { 'n', '<c-down>', ':resize -2<cr>' },
  { 'n', '<c-left>', ':vertical resize -2<cr>' },
  { 'n', '<c-right>', ':vertical resize +2<cr>' },

  { 'nv', 'y', '"+y' },
  { 'n', '<s-y>', '"+yy', { unmap = 'yy' } },
  { 'nv', 'p', '"+p' },
  { 'nv', '<s-p>', '"+<s-p>' },
  { 'nv', '<c-p>', 'p' },
  { 'nv', '<c-s-p>', '<s-p>' },
  { 'n', '<s-c>', 'cc', { unmap = true } },
  { 'n', '<s-d>', 'dd', { unmap = true } },

  { 'n', '<space>q', ':q<cr>' },
  { 'n', '<space><s-q>', ':quitall!<cr>' },
  { 'n', '<space>w', ':w<cr>' },
  { 'n', '<space>W', ':wq<cr>' },

  { 'n', '<s-u>', '<c-r>', { unmap = true } },
  { 'n', 'z', 'i<cr><esc>' },
  { 'n', '<s-z>', '<s-j>' },
  { 'nvi', '<a-f>', 'mfgg=G`f', { insert_to_normal = true } },

  { 'n', ',', 'mz$a,<esc>`z' },
  { 'n', ';', 'mz$a;<esc>`z' },
  { 'n', 'w', 'ciw' },

  { 'n', '<c-r>', ':lua reload_config()<cr>' },
  { 'n', '<a-r>', ':e $MYVIMRC<cr>' },

  { 'n', '<tab>', ':bnex<cr>' },
  { 'n', '<s-tab>', ':bprevious<cr>' },
}
