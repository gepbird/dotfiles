-- TODO: set up lsp capabilities
local keymap = {
  preset = 'none',
  ['<c-space>'] = { 'show' },
  ['<c-j>'] = { 'select_next' },
  ['<c-k>'] = { 'select_prev' },
  ['<c-l>'] = { 'accept' },
  ['<a-j>'] = { 'scroll_documentation_down' },
  ['<a-k>'] = { 'scroll_documentation_up' },
}

require 'blink-cmp'.setup {
  keymap = keymap,
  completion = {
    menu = {
      draw = {
        columns = {
          { 'kind_icon' },
          { 'label',    'label_description', gap = 1 },
          { 'source_id' },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
    },
    ghost_text = {
      enabled = true,
    },
  },
  signature = {
    enabled = true,
  },
  sources = {
    providers = {
      lsp = {
        fallbacks = {},
      },
    },
  },
  cmdline = {
    keymap = keymap,
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },
  enabled = function()
    -- completion crashes in gptmodels-nvim window, disable it
    return vim.bo.buftype ~= 'nofile'
  end,
}
