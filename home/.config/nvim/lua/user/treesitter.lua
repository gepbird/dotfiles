require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'c',
    'cpp',
    'c_sharp',
    'java',
    'dart',
    'php',
    'python',
    'lua',
    'html',
    'css',
    'javascript',
    'typescript',
    'regex',
    'sql',
    'json',
    'markdown',
    'diff',
    'vim',
    'make',
    'bash',
    'fish',
  },
  auto_install = true,
  sync_install = true,
  ignore_install = {},
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {},
  },
  rainbow = {
    enable = true,
    disable = { 'html' },
    extended_mode = true,
    max_file_lines = nil,
    colors = {
      '#d26dcf', -- pink
      '#ffd700', -- yellow
      '#00cc00', -- green
      '#d26dcf', -- pink
    },
    --termcolors = { },
  },
}

require 'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['a-'] = '@comment.outer',
        ['as'] = '@statement.outer',
        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['a,'] = '@parameter.outer',
        ['i,'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
      selection_modes = {
        ['@function.outer'] = '<s-v>',
        ['@class.outer'] = '<s-v>',
      },
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ['<space>s,'] = '@parameter.inner',
      },
      swap_previous = {
        ['<space><s-s>,'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ['gf'] = '@function.outer',
        --['gc'] = '@class.outer',
      },
    },
  },
}
