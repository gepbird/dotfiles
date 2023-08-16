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
    'markdown_inline',
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
    -- disable slow treesitter highlight for large files
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        local size_kb = math.floor(stats.size / 1024)
        vim.notify('Disabling treesitter highlighting because the buffer is too big (' .. size_kb .. ' kb)')
        vim.api.nvim_buf_set_option(buf, 'syntax', 'false')
        return true
      end
    end,
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
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}
