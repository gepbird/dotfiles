function Inspect(obj)
  print(vim.inspect(obj))
end

function Inspectr(module)
  Inspect(require(module))
end

local M = {}
-- Usage: { mode, lhs, rhs, { option1 = value1 } },
M.register_maps = function(maps)
  for _, map in pairs(maps) do
    M.register_map(map)
  end
end

M.register_map = function(map)
  local modes = map[1]

  for mode in modes:gmatch '.' do
    local rhs = map[3]
    local lhs = map[2]
    local options = map[4] or {}
    local opts = {
      remap = false,
      silent = true,
    }
    local filetype = nil

    for key, value in pairs(options) do
      if key == 'unmap' then
        if value then
          value = rhs
          vim.api.nvim_set_keymap(mode, value, '', {})
        end
      elseif key == 'filetype' then
        filetype = value
        opts.buffer = true
        break
      else
        opts[key] = value
      end
    end

    local keymap_set = function()
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    if filetype then
      M.register_autocmd { 'FileType', keymap_set, { pattern = filetype } }
    else
      keymap_set()
    end
  end
end

-- Usage: { event, callaback, { option1 = value1 } },
M.register_autocmds = function(autocmds)
  for _, autocmd in ipairs(autocmds) do
    M.register_autocmd(autocmd)
  end
end

M.register_autocmd = function(autocmd)
  local event = autocmd[1]
  if type(event) ~= 'table' then
    event = { event }
  end
  local callback = autocmd[2]
  local options = autocmd[3] or {}
  options = vim.tbl_extend('error', options, {
    callback = callback,
  })

  if options.buffer == true then
    options.buffer = 0
  end

  vim.api.nvim_create_autocmd(event, options)
end

local file_big_cache = {}
M.is_file_big = function(buffer)
  if file_big_cache[buffer] ~= nil then
    return file_big_cache[buffer]
  end

  local max_bytes = 100 * 1024
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buffer))
  local big = ok and stats and stats.size > max_bytes
  file_big_cache[buffer] = big
  return big
end

return M;
