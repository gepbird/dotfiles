require 'lspsaga'.init_lsp_saga {
  code_action_lightbulb = {
    enable = false
  },
  code_action_keys = {
    quit = { '<esc>', 'q' },
    exec = { '<cr>', 'l' },
  },
  border_style = 'rounded',
  saga_winblend = 0,
  show_outline = {
    win_position = 'left',
    left_with = 'NvimTree',
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = '┃',
    jump_key = 'l',
    auto_refresh = true,
  },
}

local action = require 'lspsaga.action'
require 'user.utils'.register_maps {
  { 'n', '<space>m', require 'lspsaga.codeaction'.code_action },
  { 'n', '<space>r', require 'lspsaga.rename'.lsp_rename },
  { 'n', '<space>k', require 'lspsaga.hover'.render_hover_doc },
  { 'n', '<space><s-k>', require 'lspsaga.signaturehelp'.signature_help },
  { 'n', '<space><c-k>', require 'lspsaga.diagnostic'.show_line_diagnostics },
  { 'n', '<c-f>', function() action.smart_scroll_with_saga(1) end },
  { 'n', '<c-b>', function() action.smart_scroll_with_saga(-1) end },
  { 'n', '<space>lo', function() require 'lspsaga.outline':render_outline() end },
}
