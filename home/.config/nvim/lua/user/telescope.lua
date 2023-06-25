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
        ['<esc>'] = actions.close,
        ['<c-l>'] = actions.select_default,
        ['<c-x>'] = actions.select_horizontal,
        ['<c-v>'] = actions.select_vertical,
        ['<c-t>'] = actions.select_tab,
        ['<a-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<a-t>'] = actions.complete_tag,

        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,

        ['<c-u>'] = actions.preview_scrolling_up,
        ['<c-d>'] = actions.preview_scrolling_down,

        ['<c-n>'] = actions.cycle_history_next,
        ['<c-p>'] = actions.cycle_history_prev,

        ['<tab>'] = actions.toggle_selection,

        ['<a-h>'] = fb.actions.toggle_hidden,
      },

      n = {
        ['<esc>'] = actions.close,
        ['<a-esc>'] = actions.close,
        ['<c-l>'] = actions.select_default,
        ['l'] = actions.select_default,
        ['<c-x>'] = actions.select_horizontal,
        ['<c-v>'] = actions.select_vertical,
        ['<c-t>'] = actions.select_tab,
        ['<a-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
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

        ['<c-n>'] = actions.cycle_history_next,
        ['<c-p>'] = actions.cycle_history_prev,

        ['<tab>'] = actions.toggle_selection,

        ['<a-h>'] = fb.actions.toggle_hidden,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--color=never',
    },
  },
  extensions = {
    media_files = {
      filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
      find_cmd = 'rg',
    },
    ['ui-select'] = {
      require 'telescope.themes'.get_dropdown {},
    },
  },
}

telescope.load_extension 'file_browser'
telescope.load_extension 'media_files'
telescope.load_extension 'ui-select'

local builtin = require 'telescope.builtin'
local find_command = { 'rg', '--files', '--glob=!.git', '--color', 'never' }

require 'user.utils'.register_maps {
  { 'n', '<space>o', function()
    builtin.find_files { hidden = true, find_command = find_command }
  end },
  { 'n', '<space><s-o>', function()
    builtin.find_files { hidden = true, no_ignore = true, find_command = find_command }
  end },
  { 'n', '<space><tab>', builtin.oldfiles },
  { 'n', '<space>tf',    fb.file_browser },
  { 'n', '<space>tg',    builtin.live_grep },
  { 'n', '<space>t<s-g>', function()
    builtin.live_grep { additional_args = { '--no-ignore' } }
  end },
  { 'n', '<space>tb',     builtin.buffers },
  { 'n', '<space>tm',     builtin.keymaps },
  { 'n', '<space>tc',     builtin.commands },
  { 'n', '<space>th',     builtin.help_tags },
  { 'n', '<space>t<s-h>', builtin.highlights },
  { 'n', '<space>tr',     builtin.registers },
}
