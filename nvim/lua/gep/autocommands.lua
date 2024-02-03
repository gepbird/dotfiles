require 'gep.utils'.register_autocmds {
  {
    'TextYankPost',
    function()
      vim.highlight.on_yank { higroup = 'IncSearch', timeout = 700 }
    end,
  },
  {
    'FileType',
    function()
      vim.cmd 'set formatoptions-=cro'
    end,
  },
  {
    { 'BufRead',                        'BufNewFile' },
    function()
      vim.bo.filetype = 'xml'
    end,
    { pattern = { '*.xaml', '*.axaml' } },
  },
}
