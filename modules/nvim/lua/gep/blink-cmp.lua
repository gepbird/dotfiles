-- TODO: set up lsp capabilities
require 'blink-cmp'.setup {
  keymap = {
    preset = 'none',
    ['<c-space>'] = { 'show' },
    ['<c-j>'] = { 'select_next' },
    ['<c-k>'] = { 'select_prev' },
    ['<c-l>'] = { 'accept' },
    ['<a-j>'] = { 'scroll_documentation_down' },
    ['<a-k>'] = { 'scroll_documentation_up' },
  },
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
    keymap = {
      preset = 'none',
      ['<c-space>'] = { 'show' },
      ['<c-j>'] = { 'select_next' },
      ['<c-k>'] = { 'select_prev' },
      ['<c-l>'] = { 'accept' },
      ['<a-j>'] = { 'scroll_documentation_down' },
      ['<a-k>'] = { 'scroll_documentation_up' },
    },
    completion = {
      menu = {
        auto_show = true,
      },
    },
  },
}
