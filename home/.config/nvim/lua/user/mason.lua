require 'mason'.setup {}

require 'mason-tool-installer'.setup {
  ensure_installed = {
    'netcoredbg',
    'debugpy',
    'prettierd',
  },
  auto_update = true,
}
