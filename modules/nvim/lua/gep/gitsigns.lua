local gs = require 'gitsigns'

-- :h gitsigns-config
gs.setup {
  signcolumn = false,
  numhl = true,
  attach_to_untracked = true,
  preview_config = {
    border = 'rounded',
  },
}

local function then_write(callback)
  return function()
    callback()
    vim.cmd ':w'
  end
end

require 'gep.utils'.register_maps {
  { 'n',  '<space>gj',     gs.next_hunk },
  { 'n',  '<space>gk',     gs.prev_hunk },
  { 'nx', '<space>gs',     then_write(gs.stage_hunk) },
  { 'n',  '<space>g<s-s>', then_write(gs.stage_buffer) },
  { 'nx', '<space>gr',     then_write(gs.reset_hunk) },
  { 'n',  '<space>g<s-r>', then_write(gs.reset_buffer) },
  { 'n',  '<space>gu',     then_write(gs.undo_stage_hunk) },
  { 'n',  '<space>gt',     gs.toggle_deleted },
  { 'n',  '<space>gp',     gs.preview_hunk },
  { 'n',  '<space>gb',     function() gs.blame_line { full = true } end },
  { 'n',  '<space>gB',     gs.blame },
  { 'n',  '<space>gd',     gs.diffthis },
}
