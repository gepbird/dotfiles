local gs = require 'gitsigns'

gs.setup {
  signs = {
    add = { text = '▎', hl = 'GitSignsAdd', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { text = '▎', hl = 'GitSignsChange', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { text = '▎', hl = 'GitSignsDelete', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { text = '▎', hl = 'GitSignsDelete', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { text = '▎', hl = 'GitSignsChange', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'rounded',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
}

local function then_write(callback)
  return function()
    callback()
    vim.cmd ':w'
  end
end

require 'user.utils'.register_maps {
  { 'n',  '<space>gj',     gs.next_hunk },
  { 'n',  '<space>gk',     gs.prev_hunk },
  { 'nx', '<space>gs',     then_write(gs.stage_hunk) },
  { 'n',  '<space>g<s-s>', then_write(gs.stage_buffer) },
  { 'nx', '<space>gr',     then_write(gs.reset_hunk) },
  { 'n',  '<space>g<s-r>', then_write(gs.reset_buffer) },
  { 'n',  '<space>gu',     then_write(gs.undo_stage_hunk) },
  { 'n',  '<space>gp',     gs.preview_hunk },
  { 'n',  '<space>gb',     function() gs.blame_line { full = true } end },
  { 'n',  '<space>gB',     gs.toggle_current_line_blame },
  { 'n',  '<space>gd',     gs.diffthis },
}
