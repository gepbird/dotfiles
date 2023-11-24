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
}

local lspconfig = require 'lspconfig'
local utils = require 'user.utils'

local servers = {
  'lua_ls',
  'pyright',
  'omnisharp',
  'clangd',
  'cssls',
  'emmet_ls',
  'tsserver',
  'html',
  'jsonls',
  'phpactor',
  'rnix',
  'texlab',
  'lemminx',
  'taplo',
  'yamlls',
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
