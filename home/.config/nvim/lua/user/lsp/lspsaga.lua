require 'lspsaga'.init_lsp_saga {
  code_action_lightbulb = {
    enable = false
  },
  code_action_keys = {
    quit = '<esc>',
    exec = 'l',
  },
  rename_action_quit = '<esc>',
  rename_in_select = true,
  border_style = 'rounded',
  saga_winblend = 0,
  show_outline = {
    win_position = 'left',
    win_with = 'NvimTree',
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = '┃',
    jump_key = 'l',
    auto_refresh = true,
  },
}

require 'user.utils'.register_maps {
  { 'n', '<space>m', function() require 'lspsaga.codeaction':code_action() end },
  { 'n', '<space>r', function() require 'lspsaga.rename':lsp_rename() end },
  { 'n', '<space>k', function() require 'lspsaga.hover':render_hover_doc() end },
  { 'n', '<space><c-k>', function() require 'lspsaga.diagnostic':show_line_diagnostics() end },
  { 'n', '<space>lo', function() require 'lspsaga.outline':render_outline() end },
}
