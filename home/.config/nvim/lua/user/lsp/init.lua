require 'user.utils'

-- TODO: keybind to close floatings
local signs = {
  DiagnosticSignError = '',
  DiagnosticSignWarn = '',
  DiagnosticSignHint = '',
  DiagnosticSignInfo = '',
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

require('nvim-lsp-installer').setup {
  automatic_installation = true
}

local lspconfig = require 'lspconfig'

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

local function lsp_highlight_document(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    register_autocommands('lsp_document_highlight', {
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
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
register_maps {
  { 'n', '<space>li', ':LspInstallInfo<cr>' },
  { 'n', '<space>ls', ':LspInfo<cr>' },
  { 'n', '<space>-', function() require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy()) end },
  { 'n', '<space>.', function() require('telescope.builtin').lsp_definitions(require('telescope.themes').get_ivy()) end },
  { 'n', '<space>:', lsp.type_definition },
  { 'n', '<space>r', lsp.rename },
  { 'n', '<space>f', lsp.formatting },
  { 'n', '<space>k', lsp.hover },
  { 'n', '<space>K', lsp.signature_help },
  { 'n', '<space>ca', lsp.code_action },
  { 'n', '<space>_', vim.diagnostic.open_float },
}

