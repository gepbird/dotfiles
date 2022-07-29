-- TODO: properly reload nvim config
local function reload_config()
  --for name,_ in pairs(package.loaded) do
  --  --if name:match('^cnull') then
  --  --package.loaded[name] = nil
  --  --end
  --end
  dofile(vim.env.MYVIMRC)
  --packer.sync()
end

require 'user.utils'.register_autocommands('main', {
  {
    'BufWritePost',
    function()
      reload_config()
    end,
    { pattern = '*/.config/nvim/**' }
  },
  {
    'TextYankPost',
    function()
      vim.highlight.on_yank { higroup = 'IncSearch', timeout = 700 }
    end
  },
  {
    'FileType',
    function()
      vim.cmd 'set formatoptions-=cro'
    end
  },
})
