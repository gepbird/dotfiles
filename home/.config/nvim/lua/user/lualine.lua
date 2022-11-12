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
  local clients = vim.lsp.buf_get_clients()
  local client_names = vim.tbl_map(function(v)
    return v.name
  end, clients)
  local client_names_normalized = vim.tbl_filter(function(v)
    return v ~= nil
  end, client_names)
  return table.concat(client_names_normalized, ',')
end

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
  lualine_c = { diagnostics, lsp },
  lualine_x = { debug_status },
  lualine_y = { filetype, filename },
  lualine_z = { 'location', 'progress' },
}

local C = require 'darkplus.palette'

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
    theme = {
      normal = {
        a = { fg = C.dark_gray, bg = '#818596', gui = 'bold' },
        b = { fg = C.fg, bg = '#282828' },
        c = { fg = C.fg, bg = '#282828' },
      },
      insert = {
        a = { fg = C.dark_gray, bg = '#84a0c6', gui = 'bold' },
      },
      visual = {
        a = { fg = C.dark_gray, bg = '#b4be82', gui = 'bold' },
      },
      replace = {
        a = { fg = C.dark_gray, bg = '#e2a478', gui = 'bold' },
      },
      inactive = {
        a = { fg = C.fg, bg = '#222222' },
        b = { fg = C.fg, bg = '#222222' },
        c = { fg = C.fg, bg = '#222222' },
      },
    },
  },
  sections = sections,
  inactive_sections = sections,
  tabline = {},
  extensions = {},
}
