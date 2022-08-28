-- TODO: keybind to close floatings
local signs = {
  DiagnosticSignError = '',
  DiagnosticSignWarn = '',
  DiagnosticSignHint = '',
  DiagnosticSignInfo = '',
}

for name, text in pairs(signs) do
  vim.fn.sign_define(name, { texthl = name, text = text, numhl = '' })
end

vim.diagnostic.config {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

require 'mason-lspconfig'.setup {
  automatic_installation = true,
}

local lspconfig = require 'lspconfig'

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

local function lsp_highlight_document(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    require 'user.utils'.register_autocommands('lsp_document_highlight', {
      {
        'CursorHold',
        function() vim.lsp.buf.document_highlight() end,
        { buffer = bufnr },
      },
      {
        'CursorMoved',
        function() vim.lsp.buf.clear_references() end,
        { buffer = bufnr },
      },
    })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp'.update_capabilities(capabilities)

lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
  on_attach = function(client, bufnr)
    lsp_highlight_document(client, bufnr)
  end,
  capabilities = capabilities,
})

local servers = {
  'sumneko_lua',
  'pyright',
  'omnisharp',
}
for _, server in ipairs(servers) do
  lspconfig[server].setup(require('user.lsp.settings.' .. server))
end

local lsp = vim.lsp.buf
local telescope = require 'telescope.builtin'
local ivy = require 'telescope.themes'.get_ivy()
require 'user.utils'.register_maps {
  { 'n', '<space>li', ':Mason<cr>' },
  { 'n', '<space>ls', ':LspInfo<cr>' },
  { 'n', '<space>-', function() telescope.lsp_references(ivy) end },
  { 'n', '<space>.', function() telescope.lsp_definitions(ivy) end },
  { 'n', '<space>:', lsp.type_definition },
  { 'n', '<space>f', function() lsp.format { async = false }; vim.cmd ':w' end },
  { 'n', '<space><s-k>', vim.lsp.buf.signature_help },
}
