-- Usage: { mode, lhs, rhs, { option = value } },
function _G.register_maps(maps)
  for _, map in pairs(maps) do
    local modes = map[1]
    local lhs = map[2]
    local options = map[4]
    local opts = {
      noremap = true,
      silent = true,
    }

    for mode in modes:gmatch'.' do
      local rhs = map[3]
      if options then
        for option_name, option_value in pairs(options) do
          if option_name == 'unmap' then
            if option_value then
            option_value = rhs
            vim.api.nvim_set_keymap(mode, option_value, '', { })
          end
          elseif option_name == 'insert_to_normal' then
            if mode == 'i' then
            if option_value == true then
              rhs = '<esc>' .. rhs .. 'a'
            else
              rhs = option_value
            end
          end
          else
            opts[option_name] = option_value
          end
        end
      end

      if type(rhs) == 'string' then
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
      else
        vim.keymap.set(mode, lhs, rhs, opts)
      end
      
    end
  end
end

-- Usage: { event, callaback, options },
function _G.register_autocommands(augroup, autocmds)
  vim.api.nvim_create_augroup(augroup, { })

  for _, autocmd in ipairs(autocmds) do
    local event = autocmd[1]
    local callback = autocmd[2]
    local options = autocmd[3]
    local opts = {
      group = augroup,
      callback = callback
    }

    if options then
      opts = vim.tbl_extend('error', opts, options)
    end

    vim.api.nvim_create_autocmd({ event }, opts)
  end
end
