local ft = require 'guard.filetype'
-- yaml doesn't work
ft 'yaml,markdown':fmt 'prettierd'
vim.g.guard_config = {
  fmt_on_save = false,
}

require 'gep.utils'.register_map {
  'n', '<space><s-f>', function() require 'guard.format'.do_fmt() end,
}
