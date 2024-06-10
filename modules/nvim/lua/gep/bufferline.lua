local disallowed_filetypes = {
  ['dap-repl'] = true,
  qf = true,
  fugitive = true,
}

-- :h bufferline-configuration
local bufferline = require 'bufferline'
bufferline.setup {
  options = {
    mode = 'buffers',
    style_preset = bufferline.style_preset.no_italic,
    indicator = {
      style = 'none',
    },
    diagnostics = 'nvim_lsp',
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, _)
      return not disallowed_filetypes[vim.bo[buf_number].filetype]
    end,
    offsets = { {
      filetype = 'neo-tree',
      text = 'File Explorer',
      text_align = 'center',
    } },
    show_buffer_close_icons = false,
    always_show_bufferline = true,
  },
}

-- TODO: remove when fixed: https://github.com/akinsho/bufferline.nvim/issues/923
local bufferline_ui = require 'bufferline.ui'
vim.diagnostic.handlers['bufferline'] = {
  show = function()
    bufferline_ui.refresh()
  end,
}

require 'gep.utils'.register_maps {
  { 'n', '<s-q>',   ':Bdelete<cr>' },
  { 'n', '<c-q>',   ':Bdelete!<cr>' },
  { 'n', '<tab>',   function() bufferline.cycle(1) end },
  { 'n', '<s-tab>', function() bufferline.cycle(-1) end },
}
