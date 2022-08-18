require 'mason'.setup {}

require 'mason-tool-installer'.setup {
  ensure_installed = {
    'debugpy',
    'netcoredbg',
  },
  auto_update = true,
}
