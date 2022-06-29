api = vim.api

function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

function map(mode, shortcut, command, options)
  if mode == 'nvo' then
    mode = ''
  end
  local opts = { noremap = true }
  if options then
    for k, v in pairs(options) do opts[k] = v end
  end
  api.nvim_set_keymap(mode, shortcut, command, opts)
end

function _G.reload_config()
  for name,_ in pairs(package.loaded) do
    if name:match('^cnull') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
end

-- Unmap defaults to learn new bindings
map('nvo', '_', '')
map('nvo', '}', '')
map('nvo', '{', '')
map('nvo', '$', '')
map('nvo', '<C-w>h', '')
map('nvo', '<C-w>j', '')
map('nvo', '<C-w>k', '')
map('nvo', '<C-w>l', '')
map('nvo', '?', '')
map('nvo', '/', '')
map('n', 'dd', '')
map('n', 'yy', '')
map('n', 'cc', '')
map('n', '<C-r>', '')


map('nvo', '<S-h>', '5h')
map('nvo', '<S-j>', '5j')
map('nvo', '<S-k>', '5k')
map('nvo', '<S-l>', '5l')

map('nvo', '<C-h>', '_')
map('nvo', '<C-j>', '}')
map('nvo', '<C-k>', '{{')
map('nvo', '<C-l>', '$')

map('nvo', '<A-h>', '<C-w>h')
map('nvo', '<A-j>', '<C-w>j')
map('nvo', '<A-k>', '<C-w>k')
map('nvo', '<A-l>', '<C-w>l')

map('nvo', 'w', '?')
map('nvo', 'e', '/')

map('n', '<S-d>', 'dd')
map('n', '<S-c>', 'cc')
map('n', '<S-y>', 'yy')

map('n', '<S-u>', '<C-r>')

map('n', '<C-S-r>', 'v:lua.reload_config()', { expr = true })

vim.o.number = true
vim.o.numberwidth = 4
vim.o.scrolloff = 10
vim.o.shiftwidth = 2
  
--nvim_create_augroup('highlight_yank', { clear = true })
api.nvim_create_autocmd({ 'TextYankPost' }, {
  callback =
    function()
      vim.highlight.on_yank({ higroup='IncSearch', timeout=700 })
      print('highlight')
    end
})

api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = vim.env.MYVIMRC,
  callback =
    function()
      _G.reload_config()
    end
})



