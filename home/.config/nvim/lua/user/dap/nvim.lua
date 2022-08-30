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

local function on_run()
  local launch = [[st -e sh -c "nvim -c \"lua require 'osv'.launch { port = ]] .. port .. [[}\""]]
  vim.fn.jobstart(launch)
  vim.wait(1000)
  dap.continue()
end

require 'user.utils'.register_autocmd {
  'BufReadPost',
  function()
    dap.on_run = on_run
  end,
  { pattern = '*/nvim/*.lua' },
}
