-- disabled for now, because after it runs, it tries to format every buffer which don't have eslint attached to it
-- TODO: re-enable this
--require 'gep.utils'.register_maps {
--  { 'n', '<space>f', function()
--    vim.cmd ':EslintFixAll'
--    vim.lsp.buf.format { async = false }
--    vim.cmd ':w'
--  end },
--}

return {}
