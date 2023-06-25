require 'mason'.setup {}

require 'mason-tool-installer'.setup {
  ensure_installed = {
    'codelldb',
    'netcoredbg',
    'debugpy',
    'autopep8',
    'jdtls',
    'prettierd',
    'xmlformatter',
  },
  auto_update = true,
}

require 'user.lsp'
