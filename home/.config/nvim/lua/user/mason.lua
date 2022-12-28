require 'mason'.setup {}

require 'mason-tool-installer'.setup {
  ensure_installed = {
    'netcoredbg',
    'debugpy',
    'jdtls',
    'prettierd',
  },
  auto_update = true,
}
