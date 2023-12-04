require 'lspsaga'.setup {
  lightbulb = {
    enable = false,
  },
  code_action = {
    num_shortcut = true,
    keys = {
      quit = '<esc>',
      exec = 'l',
    },
  },
  rename = {
    quit = '<esc>',
    exec = '<cr>',
    mark = 'x',
    configrm = '<cr>',
    in_select = true,
    whole_project = true,
  },
  ui = {
    theme = 'round',
    title = true,
    border = 'solid',
    winblend = 0,
  },
  outline = {
    win_position = 'left',
    win_with = 'NvimTree',
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = 'l',
      expand_collapse = '<s-l>',
      quit = 'q',
    },
  },
}

require 'gep.utils'.register_maps {
  { 'nx', '<space>m',        function() require 'lspsaga.codeaction':code_action() end },
  { 'n',  '<space>r',        function() require 'lspsaga.rename':lsp_rename {} end },
  { 'n',  '<space>k',        function() require 'lspsaga.hover':render_hover_doc {} end },
  { 'n',  '<space><space>k', function() require 'lspsaga.hover':render_hover_doc { '++keep' } end },
  { 'n', '<space><c-k>',
    function()
      require 'lspsaga.diagnostic.show':show_diagnostics { line = true, args = { '++unfocus' } }
    end },
  { 'n', '<space>lo', function() require 'lspsaga.symbol':outline() end },
}
