require 'gep.utils'.register_maps {
  { 'n', '<space>f', function()
    vim.cmd ':EslintFixAll'
    vim.lsp.buf.format { async = false }
    vim.cmd ':w'
  end },
}

return {}
