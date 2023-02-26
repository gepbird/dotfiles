local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettierd.with {
      disabled_filetypes = { 'html' },
    },
    null_ls.builtins.formatting.autopep8.with {
      extra_args = {
        '--indent-size=2',
      },
    },
    null_ls.builtins.formatting.xmlformat.with {
    },
  },
}
