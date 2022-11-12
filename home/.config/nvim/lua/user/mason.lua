require 'mason'.setup {}

require 'mason-tool-installer'.setup {
  ensure_installed = {
    'lua-language-server',
    'omnisharp',
    'netcoredbg',
    'pyright',
    'debugpy',
    'json-lsp',
  },
  auto_update = true,
}
