require 'mason'.setup {}

require 'mason-tool-installer'.setup {
  ensure_installed = {
    'lua-language-server',
    'omnisharp',
    'netcoredbg',
    'pyright',
    'debugpy',
    'clangd',
    'json-lsp',
  },
  auto_update = true,
}
