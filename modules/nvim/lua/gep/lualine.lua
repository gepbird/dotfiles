local branch = {
  'branch',
  icon = '',
}

local diff = {
  'diff',
  symbols = { added = ' ', modified = ' ', removed = ' ' },
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn', 'hint', 'info' },
  symbols = { error = ' ', warn = ' ', hint = ' ', info = ' ' },
  always_visible = false,
}

local lsp = function()
  local clients = vim.lsp.get_clients()
  local client_names = vim.tbl_map(function(v)
    return v.name
  end, clients)
  local client_names_normalized = vim.tbl_filter(function(v)
    return v ~= nil
  end, client_names)
  return table.concat(client_names_normalized, ',')
end

local function lsp_progress()
  return require 'lsp-progress'.progress()
end
-- listen lsp-progress event and refresh lualine
require 'gep.utils'.register_autocmds {
  {
    'User',
    require 'lualine'.refresh,
    { pattern = 'LspProgressStatusUpdated' },
  },
}

local debug_status = function()
  return require 'dap'.status()
end

local filetype = {
  'filetype',
  icon_only = true,
}

local filename = {
  'filename',
  icon_only = true,
  file_status = true,
  symbols = {
    modified = ' ● ',
    readonly = '  ',
    unnamed = '',
  },
}

local sections = {
  lualine_a = { 'mode' },
  lualine_b = { branch, diff },
  lualine_c = { diagnostics, lsp, lsp_progress },
  lualine_x = { debug_status },
  lualine_y = { filetype, filename },
  lualine_z = { 'location', 'progress' },
}

require 'lualine'.setup {
  options = {
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'dashboard', 'NvimTree', 'Outline', 'lspsagaoutline' },
    always_divide_middle = false,
    gloabalstatus = false,
    colored = true,
    update_in_insert = true,
  },
  sections = sections,
  inactive_sections = sections,
  tabline = {},
  extensions = {},
}
