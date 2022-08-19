local dap = require 'dap'
local port = 26808

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
    host = '127.0.0.1',
    port = port,
  }
}

dap.adapters.nlua = function(callback, config)
  callback { type = 'server', host = config.host, port = config.port }
end

local utils = require 'user.utils'

local function handle_continue()
  if dap.session() then
    dap.continue()
    return
  end

  local launch = [[st -e sh -c "nvim -c \"lua require 'osv'.launch { port = 26808 }\""]]
  vim.fn.jobstart(launch)
  vim.wait(1000)
  dap.continue()
end

utils.register_autocmd {
  'BufReadPost',
  function()
    utils.register_map { 'n', '<a-up>', handle_continue, { buffer = true } }
  end,
  { pattern = '*/nvim/*.lua' },
}
