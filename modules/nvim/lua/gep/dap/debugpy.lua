local dap = require 'dap'

dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    name = 'launch - debugpy',
    request = 'launch',
    program = '${file}',
    console = 'integratedTerminal',
  },
}
