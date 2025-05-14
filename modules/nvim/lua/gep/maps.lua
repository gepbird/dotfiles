require 'gep.utils'.register_maps {
  { 'nxo', '<s-h>',     '5h' },
  { 'nxo', '<s-j>',     '5j' },
  { 'nxo', '<s-k>',     '5k' },
  { 'nxo', '<s-l>',     '5l' },

  { 'nxo', '<c-h>',     '_',                      {} },
  { 'nxo', '<c-j>',     '}',                      { unmap = true } },
  { 'nxo', '<c-k>',     '{',                      { unmap = true } },
  { 'nxo', '<c-l>',     '$',                      { unmap = true } },

  { 'nxi', '<a-h>',     '<c-w>h' },
  { 'nxi', '<a-j>',     '<c-w>j' },
  { 'nxi', '<a-k>',     '<c-w>k' },
  { 'nxi', '<a-l>',     '<c-w>l' },

  { 'i',   '<c-h>',     '<left>' },
  { 'i',   '<c-j>',     '<down>' },
  { 'i',   '<c-k>',     '<up>' },
  { 'i',   '<c-l>',     '<right>' },

  { 'i',   '<a-h>',     '<bs>' },
  { 'i',   '<a-l>',     '<del>' },

  { 'n',   '<space>h',  ':split<cr>' },
  { 'n',   '<space>v',  ':vsplit<cr>' },

  { 'nxo', 'e',         '/',                      { unmap = true } },
  { 'nxo', '<s-e>',     '?',                      { unmap = true } },
  { 'n',   '<c-e>',     ':nohlsearch<cr>' },

  { 'nxo', 'b',         '%',                      { unmap = true } },
  { 'nxo', '_',         ',',                      { unmap = true } },
  { 'nxo', '-',         ';',                      { unmap = true } },

  { 'x',   '<',         '<gv' },
  { 'x',   '>',         '>gv' },
  { 'n',   '>',         '>>' },
  { 'n',   '<',         '<<' },

  { 'n',   '<c-up>',    ':resize +2<cr>' },
  { 'n',   '<c-down>',  ':resize -2<cr>' },
  { 'n',   '<c-left>',  ':vertical resize -2<cr>' },
  { 'n',   '<c-right>', ':vertical resize +2<cr>' },


  --{ 'x', 'p', function()
  --  local src_mode = vim.fn.getregtype '"'
  --  local dst_mode = vim.fn.mode()
  --  if src_mode == dst_mode then
  --    vim.cmd 'normal! "_dP'
  --  elseif src_mode == 'V' and dst_mode == 'v' then
  --    vim.cmd 'normal! "_di\r'
  --    vim.cmd 'normal! P'
  --  elseif src_mode == 'v' and dst_mode == 'V' then
  --    vim.cmd 'normal! "_dO'
  --    vim.cmd 'normal! p'
  --  end
  --end },

  -- when pasting, trim trailing newlines if the content came from outside of nvim
  -- so nvim pastes the content in the current line of opening a new one
  { 'n', 'p',
    function()
      local last_nvim_content = vim.fn.getreg '"'
      local clipboard_content = vim.fn.getreg '+'
      local pasted_from_nvim = last_nvim_content == clipboard_content
      if not pasted_from_nvim then
        local _, newlines = string.gsub(clipboard_content, '\n', '')
        if newlines == 1 then
          local content_stripped = string.gsub(clipboard_content, '\n$', '')
          vim.fn.setreg('+', content_stripped)
        end
      end
      vim.cmd 'normal! p'
    end,
  },

  { 'n',   'gy',           'mfggy<s-g>`f' },
  { 'n',   'gp',           'gg"_d<s-g>P' },

  { 'n',   '<s-y>',        'yy',                                   { unmap = true } },
  { 'n',   '<s-c>',        'cc',                                   { unmap = true } },
  { 'n',   '<s-d>',        'dd',                                   { unmap = true } },

  { 'n',   '<space>q',     ':q<cr>' },
  { 'n',   '<space><s-q>', ':quitall!<cr>' },
  { 'n',   '<space>w',     ':w ++p<cr>' },
  { 'n',   '<space>W',     ':wq ++p<cr>' },

  { 'n',   '<space><s-m>', ':messages<cr>' },
  { 'n',   '<space>n',     function() print(vim.fn.expand '%') end },
  { 'n',   '<space><s-n>', function() print(vim.bo.filetype) end },
  { 'n',   '<a-q>',        'q' },
  { 'n',   '<space><s-r>', ':w<cr>:e<cr>' },

  { 'n',   '<s-u>',        '<c-r>',                                { unmap = true } },
  { 'n',   'z',            'i<cr><esc>' },
  { 'n',   '<s-z>',        '<s-j>' },
  { 'nxi', '<a-f>',        'mfgg=G`f' },

  { 'n',   ',',            'mz<s-a>,<esc>`z' },
  { 'n',   ';',            'mz<s-a>;<esc>`z' },
  { 'n',   'w',            'ciw' },

  { 'n',   '<c-n>',        ':enew<cr>' },

  { 'n',   'gl',           '<s-k>' },
}
