require('nvim-treesitter.configs').setup {
  ensure_installed = 'all',
  auto_install = true,
  sync_install = true,
  ignore_install = { },
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = { },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { },
  },
  rainbow = {
    enable = true,
    disable = { },
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

