local dap = require 'dap'
local dapui = require 'dapui'
local widgets = require 'dap.ui.widgets'

vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#E51400' })
vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { link = 'DapBreakpoint' })
vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#F3C302' })
vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = 'DapBreakpointRejected' })
vim.fn.sign_define('DapStopped', { text = ' ', texthl = 'DapStopped' })

dapui.setup {
  icons = { expanded = '▾', collapsed = '▸' },
  mappings = {
    expand = { 'h', 'l' },
    open = '<cr>',
    remove = '<s-d>',
    edit = '<s-c>',
    repl = 'r',
    toggle = '<tab>',
  },
  expand_lines = true,
  layouts = {
    --{
    --  elements = {
    --    { id = 'scopes', size = 0.25 },
    --    'watches',
    --  },
    --  size = 40,
    --  position = 'left',
    --},
    {
      elements = {
        'repl',
        --'console',
      },
      size = 0.25,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = 'rounded',
    mappings = {
      close = { 'q', '<esc>' },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
  },
}

require 'nvim-dap-virtual-text'.setup {
  enabled = true,                        -- enable this plugin (the default)
  enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = true,       -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,               -- show stop reason when stopped for exceptions
  commented = false,                     -- prefix virtual text with comment string
  only_first_definition = false,         -- only show virtual text at first definition (if there are multiple)
  all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- experimental features:
  virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil,               -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

local telescope_dap = require 'telescope'.load_extension 'dap'

-- Override these for debuggers
dap.on_run = dap.continue
dap.on_restart = dap.run_last

require 'gep.utils'.register_maps {
  { 'n', '<space>b',     dap.toggle_breakpoint },
  { 'n', '<space><s-b>', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end },
  { 'n', '<space><c-b>', function() dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ') end },
  { 'n', '<a-up>', function()
    if dap.session() then
      dap.continue()
      return
    end
    dap.on_run()
  end },
  { 'n', '<space>dp', function() dap.on_restart() end },
  { 'n', '<a-down>',  dap.step_over },
  { 'n', '<a-left>',  dap.step_out },
  { 'n', '<a-right>', dap.step_into },
  { 'n', '<end>',     dap.terminate },
  { 'n', '<a-cr>', function()
    local ok, nvim_tree = pcall(require, 'nvim-tree.view')
    if ok then
      nvim_tree.close()
    end
    dapui.toggle()
  end },
  { 'n',  '<space><a-k>',  widgets.hover },
  { 'n',  '<space>td',     telescope_dap.commands },
  { 'nv', '<space>de',     function() dapui.eval() end },
  { 'nv', '<space>d<s-e>', function() dapui.eval(nil, { enter = true }) end },
  { 'n',  '<space>d<c-e>', function() dapui.eval(vim.fn.input 'Expression: ') end },
  { 'n',  '<space>dl',     function() dapui.float_element('scopes', { enter = true }) end },
  { 'n',  '<space>db',     function() dapui.float_element('breakpoints', { enter = true }) end },
  { 'n',  '<space>dw',     function() dapui.float_element('watches', { enter = true }) end },
  { 'n',  '<space>ds',     function() dapui.float_element('stacks', { enter = true }) end },
  { 'n',  '<space>dr',     function() dapui.float_element('repl', { enter = true }) end },
  { 'n',  '<space>dc',     function() dapui.float_element('console', { enter = true }) end },
  { 'n',  't',             telescope_dap.variables,                                            { filetype = { 'dapui_scopes', 'dapui_watches' } } },
  { 'n',  't',             telescope_dap.frames,                                               { filetype = 'dapui_stacks' } },
}

require 'gep.dap.debugpy'
require 'gep.dap.netcoredbg'
