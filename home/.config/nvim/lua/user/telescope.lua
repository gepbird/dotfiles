require 'user.utils'

local telescope = require 'telescope'

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '-uu'
    },
  }
}

pcall(telescope.load_extension, 'file_browser')

register_maps {
  { 'n', '<space>o', '<cmd>Telescope find_files find_command=rg,--hidden,--files<cr>' },
  { 'n', '<space><tab>', '<cmd>Telescope oldfiles<cr>' },
  { 'n', '<space>tf', '<cmd>Telescope file_browser<cr>' },
  { 'n', '<space>tg', '<cmd>Telescope live_grep<cr>' },
  { 'n', '<space>tb', '<cmd>Telescope buffers<cr>' },
  { 'n', '<space>tm', '<cmd>Telescope keymaps<cr>' },
  { 'n', '<space>tc', '<cmd>Telescope commands<cr>' },
  { 'n', '<space>th', '<cmd>Telescope help_tags<cr>' },
}

