require 'bufferline'.setup {
  options = {
    mode = 'buffers', -- set to 'tabs' to only show tabpages instead
    --numbers = 'none' | 'ordinal' | 'buffer_id' | 'both' | function({ ordinal, id, lower, raise }): string,
    numbers = 'none',
    close_command = 'Bdelete! %d', -- can be a string | function, see 'Mouse actions'
    right_mouse_command = 'Bdelete! %d', -- can be a string | function, see 'Mouse actions'
    left_mouse_command = 'buffer %d', -- can be a string | function, see 'Mouse actions'
    middle_mouse_command = nil, -- can be a string | function, see 'Mouse actions'
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'icon',
    },
    modified_icon = '●',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    --name_formatter = function(buf)  -- buf contains a 'name', 'path' and 'bufnr'
    --  -- remove extension from markdown files for example
    --  if buf.name:match('%.md') then
    --    return vim.fn.fnamemodify(buf.name, ':t:r')
    --  end
    --end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, _, _, _)
      return '(' .. count .. ')'
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number, _)
      local filetype = vim.bo[buf_number].filetype
      if filetype ~= 'dap-repl' and
          filetype ~= 'qf' then
        return true
      end
    end,
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'left',
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'thin',
    --enforce_regular_tabs = false | true,
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    sort_by = function(buffer_a, buffer_b)
      return buffer_a.id < buffer_b.id
    end,
  },
}

require 'user.utils'.register_maps {
  { 'n', '<s-q>', ':Bdelete<cr>' },
  { 'n', '<c-q>', ':Bdelete!<cr>' },
}
