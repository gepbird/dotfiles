local disallowed_filetypes = {
  ['dap-repl'] = true,
  qf = true,
  fugitive = true,
}
local seve = vim.diagnostic.severity

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
    diagnostics_update_on_event = true,
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
    custom_areas = {
      right = function()
        local result = {}
        local diagnostics_count = vim.diagnostic.count()
        local process_diagnostics = function(severity, display)
          local count = diagnostics_count[severity]
          if count then
            display.text = display.text .. count
            table.insert(result, display)
          end
        end
        process_diagnostics(seve.ERROR, { text = '  ', link = 'DiagnosticError' })
        process_diagnostics(seve.WARN, { text = '  ', link = 'DiagnosticWarn' })
        process_diagnostics(seve.HINT, { text = '  ', link = 'DiagnosticHint' })
        process_diagnostics(seve.INFO, { text = '  ', link = 'DiagnosticInfo' })
        return result
      end,
    },
  },
}

require 'gep.utils'.register_maps {
  { 'n', '<s-q>',   ':Bdelete<cr>' },
  { 'n', '<c-q>',   ':Bdelete!<cr>' },
  { 'n', '<tab>',   function() bufferline.cycle(1) end },
  { 'n', '<s-tab>', function() bufferline.cycle(-1) end },
}
