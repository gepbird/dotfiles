local telescope = require 'telescope'
local action_state = require 'telescope.actions.state'
local actions = require 'telescope.actions'
local conf = require 'telescope.config'.values
local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'

-- TODO: this could be improved a lot, like making previewing work, adding back icons
local function multi_stage_grep(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local manager = picker.manager

  local results = {}
  for result in manager:iter() do
    table.insert(results, result)
  end

  pickers.new({}, {
    prompt_title = 'Multi Stage Live Grep',
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry[1],
          ordinal = entry.text,
        }
      end,
    },
    sorter = conf.generic_sorter {},
  }):find()
end

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
        ['<c-g>'] = actions.move_to_bottom,

        ['<c-u>'] = actions.preview_scrolling_up,
        ['<c-d>'] = actions.preview_scrolling_down,

        ['<c-n>'] = actions.cycle_history_next,
        ['<c-p>'] = actions.cycle_history_prev,

        ['<tab>'] = actions.toggle_selection,
        ['<c-f>'] = multi_stage_grep,
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
    ['ui-select'] = {
      require 'telescope.themes'.get_dropdown {},
    },
  },
}

telescope.load_extension 'ui-select'
telescope.load_extension 'fzf'

local builtin = require 'telescope.builtin'
local glob_pattern = '!.git'
local find_command = { 'rg', '--files', '--glob=' .. glob_pattern, '--color', 'never' }

require 'gep.utils'.register_maps {
  { 'n', '<space>o', function()
    builtin.find_files { hidden = true, find_command = find_command }
  end },
  { 'n', '<space><s-o>', function()
    builtin.find_files { hidden = true, no_ignore = true, find_command = find_command }
  end },
  { 'n', '<space><tab>',  builtin.oldfiles },
  { 'n', '<space>tg', function()
    builtin.live_grep { glob_pattern = glob_pattern }
  end },
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
