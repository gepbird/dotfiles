require 'user.utils'

local hop = require 'hop'
local hint = require 'hop.hint'
local dir = hint.HintDirection

require 'hop'.setup {
  quit_key = '<esc>',
  jump_on_sole_occurrence = true,
  case_insensitive = true,
  create_hl_autocommands = true,
  hint_position = hint.HintPosition.END,
}

local function hint_words(opts) return function() hop.hint_words(opts) end end

local function hint_char1(opts) return function() hop.hint_char1(opts) end end

local function hint_char2(opts) return function() hop.hint_char2(opts) end end

local function hint_lines(opts) return function() hop.hint_lines(opts) end end

register_maps {
  { 'nvo', 'qw', hint_words {} },
  { 'nvo', 'qh', hint_char1 { direction = dir.BEFORE_CURSOR, current_line_only = true } },
  { 'nvo', 'qj', hint_lines { direction = dir.AFTER_CURSOR } },
  { 'nvo', 'qk', hint_lines { direction = dir.BEFORE_CURSOR } },
  { 'nvo', 'ql', hint_char1 { direction = dir.AFTER_CURSOR, current_line_only = true } },
  { 'nvo', 'S', hint_char2 {} },
}
