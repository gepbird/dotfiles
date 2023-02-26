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
local utils = require 'user.utils'

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

local function lsp_highlight_document(client, _)
  if client.server_capabilities.documentHighlightProvider then
    utils.register_autocmds {
      { 'CursorHold',  vim.lsp.buf.document_highlight, { buffer = true } },
      { 'CursorMoved', vim.lsp.buf.clear_references,   { buffer = true } },
    }
  end
end

lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
  on_attach = function(client, bufnr)
    lsp_highlight_document(client, bufnr)

    -- Omnisharp bug workaround: https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
    if client.name == 'omnisharp' then
      client.server_capabilities.semanticTokensProvider.legend = {
        tokenModifiers = { 'static' },
        tokenTypes = { 'comment', 'excluded', 'identifier', 'keyword', 'keyword', 'number', 'operator', 'operator',
          'preprocessor', 'string', 'whitespace', 'text', 'static', 'preprocessor', 'punctuation', 'string', 'string',
          'class', 'delegate', 'enum', 'interface', 'module', 'struct', 'typeParameter', 'field', 'enumMember',
          'constant', 'local', 'parameter', 'method', 'method', 'property', 'event', 'namespace', 'label', 'xml', 'xml',
          'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml', 'xml',
          'xml', 'xml', 'xml', 'regexp', 'regexp', 'regexp', 'regexp', 'regexp', 'regexp', 'regexp', 'regexp', 'regexp' },
      }
    end
  end,
})

local servers = {
  'lua_ls',
  'pyright',
  'omnisharp',
  'clangd',
  'cssls',
  'emmet_ls',
  'tsserver',
  'html',
  'astro',
  'phpactor',
}
for _, server in ipairs(servers) do
  local ok, config = pcall(require, 'user.lsp.' .. server)
  if not ok then
    config = {}
  end
  lspconfig[server].setup(config)
end

local lsp = vim.lsp.buf
local telescope = require 'telescope.builtin'
local ivy = require 'telescope.themes'.get_ivy()
utils.register_maps {
  { 'n', '<space>li',    ':Mason<cr>' },
  { 'n', '<space>ls',    ':LspInfo<cr>' },
  { 'n', '<space>-',     function() telescope.lsp_references(ivy) end },
  { 'n', '<space>.',     vim.lsp.buf.definition }, -- omnisharp-extended doesn't work with telescope definitions
  { 'n', '<space>:',     function() telescope.lsp_type_definitions(ivy) end },
  { 'n', '<space>f',     function()
    lsp.format { async = false };
    vim.cmd ':w'
  end },
  { 'n', '<space><s-k>', vim.lsp.buf.signature_help },
}
