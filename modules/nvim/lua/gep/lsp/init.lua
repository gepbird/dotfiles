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

local lspconfig = require 'lspconfig'
local utils = require 'gep.utils'

local servers = {
  lua_ls = { 'lua' },
  ruff = { 'python' },
  pyright = { 'python' },
  omnisharp = { 'cs' },
  clangd = { 'c' },
  cssls = { 'css', 'scss' },
  stylelint_lsp = { 'css', 'scss' },
  emmet_ls = { 'html', 'typescriptreact', 'javascriptreact' },
  eslint = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  ts_ls = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  html = { 'html' },
  jsonls = { 'json' },
  phpactor = { 'php' },
  nixd = { 'nix' },
  texlab = { 'tex' },
  lemminx = { 'xml' },
  taplo = { 'toml' },
  yamlls = { 'yaml' },
}

local function toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end
toggle_inlay_hints()

local lsp = vim.lsp.buf
local telescope = require 'telescope.builtin'
local ivy = require 'telescope.themes'.get_ivy()
utils.register_maps {
  { 'n', '<space>ls', ':LspInfo<cr>' },
  { 'n', '<space>lh', toggle_inlay_hints },
  { 'n', '<space>-',  function() telescope.lsp_references(ivy) end },
  { 'n', '<space>.',  function() telescope.lsp_definitions(ivy) end },
  { 'n', '<space>:',  function() telescope.lsp_type_definitions(ivy) end },
  { 'n', '<space>f', function()
    lsp.format { async = false };
    vim.cmd ':w'
  end },
  { 'n', '<space><s-k>', vim.lsp.buf.signature_help },
}

for server, languages in pairs(servers) do
  for _, language in ipairs(languages) do
    -- lazy load servers
    utils.register_autocmd {
      'FileType',
      function()
        -- don't load it multiple times
        if not servers[server] then
          return
        end
        servers[server] = nil

        local ok, config = pcall(require, 'gep.lsp.' .. server)
        if not ok then
          config = {}
        end
        lspconfig[server].setup(config)
        vim.cmd [[:LspStart]]
      end,
      { pattern = language },
    }
  end
end
