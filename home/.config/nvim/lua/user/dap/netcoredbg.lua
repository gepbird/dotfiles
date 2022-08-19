local dap = require 'dap'

dap.adapters.coreclr = {
  type = 'executable',
  command = vim.fn.expand '~/.local/share/nvim/mason/packages/netcoredbg/build/netcoredbg',
  args = { '--interpreter=vscode' },
}

local utils = require 'user.utils'

local function generate_configurations(dll_paths)
  local cwd_escaped = string.gsub(vim.fn.getcwd(), '%-', '%%-')
  for _, dll_path in pairs(dll_paths) do
    local dll_path_truncated = string.gsub(dll_path, cwd_escaped, '')
    table.insert(dap.configurations.cs, {
      type = 'coreclr',
      name = '[Generated] Launch .' .. dll_path_truncated,
      request = 'launch',
      program = '${workspaceFolder}' .. dll_path_truncated,
      console = 'externalTerminal',
    })
  end
end

local function on_continue()
  if dap.session() then
    dap.continue()
    return
  end

  local dll_paths = {}
  vim.fn.jobstart('dotnet build --nologo', {

    on_stdout = function(_, lines, _)
      for _, line in ipairs(lines) do
        print(line)
        local _, dll_pos = string.find(line, ' -> ')
        if dll_pos then
          local dll_path = string.sub(line, dll_pos + 1)
          table.insert(dll_paths, dll_path)
        end
      end
    end,

    on_exit = function(_, code, _)
      if code == 0 then
        dap.configurations.cs = {}
        require 'dap.ext.vscode'.load_launchjs(nil, { coreclr = { 'cs' } })
        generate_configurations(dll_paths)
        dap.continue()
      else
        vim.notify('Build failed', 'error', { title = 'netcoredbg' })
      end
    end,

  })
end

utils.register_autocmd {
  'FileType',
  function()
    dap.on_continue = on_continue
  end,
  { pattern = 'cs' },
}
