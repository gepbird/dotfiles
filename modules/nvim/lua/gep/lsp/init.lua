local seve = vim.diagnostic.severity
vim.diagnostic.config {
  virtual_text = false,
  signs = {
    text = {
      [seve.ERROR] = ' ',
      [seve.WARN] = ' ',
      [seve.INFO] = ' ',
      [seve.HINT] = ' ',
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
}

local utils = require 'gep.utils'

local servers = {
  'lua_ls',
  'ruff',
  'pyright',
  'omnisharp',
  'clangd',
  'cssls',
  'stylelint_lsp',
  'emmet_ls',
  'eslint',
  'ts_ls',
  'html',
  'jsonls',
  'phpactor',
  'nixd',
  'texlab',
  'tinymist',
  'lemminx',
  'taplo',
  'yamlls',
}

for _, server in ipairs(servers) do
  local ok, config = pcall(require, 'gep.lsp.' .. server)
  if not ok then
    config = {}
  end
  config.capabilities = require 'blink.cmp'.get_lsp_capabilities(config.capabilities)
  vim.lsp.enable(server)
  vim.lsp.config(server, config)
end

local function toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end
toggle_inlay_hints()

local telescope = require 'telescope.builtin'
local ivy = require 'telescope.themes'.get_ivy()
utils.register_maps {
  { 'n', '<space>ls', ':checkhealth vim.lsp<cr>' },
  { 'n', '<space>lh', toggle_inlay_hints },
  { 'n', '<space>-',  function() telescope.lsp_references(ivy) end },
  { 'n', '<space>.',  function() telescope.lsp_definitions(ivy) end },
  { 'n', '<space>:',  function() telescope.lsp_type_definitions(ivy) end },
  { 'n', '<space>f', function()
    vim.lsp.buf.format { async = false };
    vim.cmd ':w'
  end },
  { 'n', '<space><s-k>', vim.lsp.buf.signature_help },
}
