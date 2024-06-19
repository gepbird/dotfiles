local trouble = require'trouble'
-- :h trouble.nvim-trouble-configuration
trouble.setup {
}

require 'gep.utils'.register_maps {
  { 'n', '<space>,', function() trouble.toggle('diagnostics') end },
}

-- TODO: remove when merged: https://github.com/Mofiqul/vscode.nvim/pull/203
vim.api.nvim_set_hl(0, 'TroubleNormal', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'TroubleNormalNC', { link = 'Normal' })
