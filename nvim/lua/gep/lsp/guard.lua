local ft = require 'guard.filetype'
-- TODO: uncomment when added back https://github.com/gepbird/guard-collection/commit/03107f58d3224bb6b8dee30f13edd776cdab8ba4
--ft 'javascript,typescript,css,json,yaml,markdown':fmt 'prettierd'
ft 'css,yaml,markdown':fmt 'prettier'
ft 'python':fmt 'yapf'
  :extra('--style', '{indent_width: 2}')
require 'guard'.setup {
  fmt_on_save = true,
  lsp_as_default_formatter = false,
}
