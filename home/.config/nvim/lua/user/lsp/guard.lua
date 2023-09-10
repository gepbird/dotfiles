local ft = require 'guard.filetype'
ft 'javascript,typescript,css,json,yaml,markdown':fmt 'prettierd'
ft 'python':fmt {
  cmd = 'yapf',
  args = { '--style', '{indent_width: 2}' },
  stdin = true,
}
require 'guard'.setup {
  fmt_on_save = true,
  lsp_as_default_formatter = false,
}
