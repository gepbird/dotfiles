require 'mason'.setup {}

require 'mason-tool-installer'.setup {
  ensure_installed = {
    'netcoredbg',
    'debugpy',
    'autopep8',
    'jdtls',
    'prettierd',
    'xmlformatter',
  },
  auto_update = true,
}
