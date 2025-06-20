local keymap = {
  preset = 'none',
  ['<c-space>'] = { 'show', 'show_documentation' },
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
    -- TODO: enable when fixed: https://github.com/Saghen/blink.cmp/issues/1932
    --documentation = {
    --  auto_show = true,
    --  auto_show_delay_ms = 0,
    --},
    ghost_text = {
      enabled = true,
    },
  },
  signature = {
    enabled = true,
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
    providers = {
      lsp = {
        fallbacks = {},
      },
      copilot = {
        name = 'copilot',
        module = 'blink-cmp-copilot',
        score_offset = 100,
        async = true,
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
