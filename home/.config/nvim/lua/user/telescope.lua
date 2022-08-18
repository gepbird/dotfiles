local telescope = require 'telescope'
local actions = require 'telescope.actions'
local fb = require 'telescope'.extensions.file_browser

telescope.setup {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = ' ',
    path_display = { 'smart' },

    mappings = {
      i = {
        ['<a-esc>'] = actions.close,
        ['<cr>'] = actions.select_default,
        ['<c-x>'] = actions.select_horizontal,
        ['<c-v>'] = actions.select_vertical,
        ['<c-t>'] = actions.select_tab,
        ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<a-q>'] = actions.send_selected_to_qflist + actions.open_qflist, -- TODO: if nothing is selected, select everything
        ['<a-t>'] = actions.complete_tag,

        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,

        ['<c-u>'] = actions.preview_scrolling_up,
        ['<c-d>'] = actions.preview_scrolling_down,

        ['<c-l>'] = actions.cycle_history_next,
        ['<c-h>'] = actions.cycle_history_prev,

        ['<tab>'] = actions.toggle_selection,
        ['<s-tab>'] = actions.toggle_selection,

        ['<a-h>'] = fb.actions.toggle_hidden,
      },

      n = {
        ['<esc>'] = actions.close,
        ['<cr>'] = actions.select_default,
        ['<c-x>'] = actions.select_horizontal,
        ['<c-v>'] = actions.select_vertical,
        ['<c-t>'] = actions.select_tab,
        ['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
        ['<a-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
        ['<a-t>'] = actions.complete_tag,

        ['j'] = actions.move_selection_next,
        ['k'] = actions.move_selection_previous,
        ['<s-j>'] = actions.move_selection_next + actions.move_selection_next + actions.move_selection_next +
            actions.move_selection_next + actions.move_selection_next,
        ['<s-k>'] = actions.move_selection_previous + actions.move_selection_previous + actions.move_selection_previous +
            actions.move_selection_previous + actions.move_selection_previous,
        ['<c-j>'] = actions.results_scrolling_up,
        ['<c-k>'] = actions.results_scrolling_down,
        ['gg'] = actions.move_to_top,
        ['<s-g>'] = actions.move_to_bottom,

        ['<c-u>'] = actions.preview_scrolling_up,
        ['<c-d>'] = actions.preview_scrolling_down,

        ['<c-l>'] = actions.cycle_history_next,
        ['<c-h>'] = actions.cycle_history_prev,

        ['<tab>'] = actions.toggle_selection,
        ['<s-tab>'] = actions.toggle_selection,

        ['?'] = actions.which_key,
        ['<a-h>'] = fb.actions.toggle_hidden,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '-uu',
    },
  },
  extensions = {
    media_files = {
      filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
      find_cmd = 'rg',
    },
  },
}

telescope.load_extension 'file_browser'
telescope.load_extension 'media_files'

require 'user.utils'.register_maps {
  { 'n', '<space>o', '<cmd>Telescope find_files find_command=rg,--hidden,--files<cr>' },
  { 'n', '<space><tab>', '<cmd>Telescope oldfiles<cr>' },
  { 'n', '<space>tf', fb.file_browser },
  { 'n', '<space>tg', '<cmd>Telescope live_grep<cr>' },
  { 'n', '<space>tb', '<cmd>Telescope buffers<cr>' },
  { 'n', '<space>tm', '<cmd>Telescope keymaps<cr>' },
  { 'n', '<space>tc', '<cmd>Telescope commands<cr>' },
  { 'n', '<space>th', '<cmd>Telescope help_tags<cr>' },
  { 'n', '<space>t<s-h>', '<cmd>Telescope highlights<cr>' },
  { 'n', '<space>tr', '<cmd>Telescope registers<cr>' },
}
