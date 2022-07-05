function _G.register_maps(maps)
  local default_options = function() return { noremap = true, silent = true } end
  for _, map in pairs(maps) do
    local modes = map[1]
    local key = map[2]
    local options = map[4]
    local opts = default_options()
    for mode in modes:gmatch'.' do
      local action = map[3]
      if options then
        for option_name, option_value in pairs(options) do
          if option_name == 'unmap' and option_value == true then
            option_value = action
            api.nvim_set_keymap(mode, option_value, '', { }) 
          end
          if option_name == 'insert_to_normal' and mode == 'i' then
            if option_value == true then
              action = '<esc>' .. action .. 'a'
            else 
              action = option_value
            end
          end
        end
      end
      api.nvim_set_keymap(mode, key, action, opts)
    end
  end
end
