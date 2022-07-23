return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand '$VIMRUNTIME/lua'] = true,
          [vim.fn.stdpath 'config' .. '/lua'] = true,
        },
        telemetry = {
          enable = false,
        },
      },
      runtime = {
        version = 'LuaJIT',
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
          quote_style = 'single',
          call_arg_parentheses = 'remove',
          -- TODO: trailing_comma = 'true',
        },
      },
    },
  },
}
