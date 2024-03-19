require 'neo-tree'.setup {
  -- Close Neo-tree if it is the last window left in the tab
  close_if_last_window = false,
  popup_border_style = 'rounded',
  enable_git_status = true,
  enable_diagnostics = true,
  -- when opening files, do not use windows containing these filetypes or buftypes
  open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf' },
  -- used when sorting files and directories in the tree
  sort_case_insensitive = false,
  -- use a custom function for sorting files and directories in the tree
  sort_function = nil,
  -- this sorts files and directories descendantly
  -- sort_function = function (a,b)
  --    if a.type == b.type then
  --       return a.path > b.path
  --     else
  --       return a.type > b.type
  --     end
  --   end,
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      -- extra padding on left hand side
      padding = 1,
      -- indent guides
      with_markers = true,
      indent_marker = '│',
      last_indent_marker = '└',
      highlight = 'NeoTreeIndentMarker',
      -- expander config, needed for nesting files
      -- if nil and file nesting is enabled, will enable expanders
      with_expanders = nil,
      expander_collapsed = '',
      expander_expanded = '',
      expander_highlight = 'NeoTreeExpander',
    },
    icon = {
      folder_closed = '',
      folder_open = '',
      folder_empty = '',
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = '',
      highlight = 'NeoTreeFileIcon',
    },
    modified = {
      symbol = '[+]',
      highlight = 'NeoTreeModified',
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = 'NeoTreeFileName',
    },
    git_status = {
      symbols = {
        -- Change type
        -- or "✚", but this is redundant info if you use git_status_colors on the name
        added     = '',
        -- or "", but this is redundant info if you use git_status_colors on the name
        modified  = '',
        -- this can only be used in the git_status source
        deleted   = '✖',
        -- this can only be used in the git_status source
        renamed   = '󰁕',
        -- Status type
        untracked = '',
        ignored   = '',
        unstaged  = '󰄱',
        staged    = '',
        conflict  = '',
      },
    },
    -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
    file_size = {
      enabled = true,
      -- min width of window required to show this column
      required_width = 64,
    },
    type = {
      enabled = true,
      -- min width of window required to show this column
      required_width = 122,
    },
    last_modified = {
      enabled = true,
      -- min width of window required to show this column
      required_width = 88,
    },
    created = {
      enabled = true,
      -- min width of window required to show this column
      required_width = 110,
    },
    symlink_target = {
      enabled = false,
    },
  },
  -- A list of functions, each representing a global custom command
  -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
  -- see `:h neo-tree-custom-commands-global`
  commands = {},
  window = {
    position = 'left',
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      --['l'] = 'open',
      ['l'] = 'open_with_window_picker',
      -- TODO: uncomment when fixed: https://github.com/nvim-neo-tree/neo-tree.nvim/issues/777
      --["L"] = "expand_all_subnodes",
      ['h'] = 'close_node',
      ['H'] = 'close_all_subnodes',
      -- close preview or floating neo-tree window
      ['<esc>'] = 'cancel',
      -- enter preview mode, which shows the current node without focusing
      ['P'] = { 'toggle_preview', config = { use_float = true } },
      --['l'] = 'focus_preview',
      ['S'] = 'open_split',
      ['s'] = 'open_vsplit',
      -- ["S"] = "split_with_window_picker",
      -- ["s"] = "vsplit_with_window_picker",
      ['t'] = 'open_tabnew',
      -- ["<cr>"] = "open_drop",
      -- ["t"] = "open_tab_drop",
      ['a'] = {
        'add',
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          -- "none", "relative", "absolute"
          show_path = 'none',
        },
      },
      -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ['A'] = 'add_directory',
      ['d'] = 'delete',
      ['r'] = 'rename',
      ['y'] = 'copy_to_clipboard',
      ['x'] = 'cut_to_clipboard',
      ['p'] = 'paste_from_clipboard',
      -- takes text input for destination, also accepts the optional config.show_path option like "add":
      ['c'] = 'copy',
      -- ["c"] = {
      --  "copy",
      --  config = {
      --    show_path = "none" -- "none", "relative", "absolute"
      --  }
      --}
      -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ['m'] = 'move',
      ['q'] = 'close_window',
      ['R'] = 'refresh',
      ['?'] = 'show_help',
      ['<'] = 'prev_source',
      ['>'] = 'next_source',
      ['i'] = 'show_file_details',
    },
  },
  nesting_rules = {},
  filesystem = {
    filtered_items = {
      -- when true, they will just be displayed differently than normal items
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        --"node_modules"
      },
      -- uses glob style patterns
      hide_by_pattern = {
        --"*.meta",
        --"*/src/*/tsconfig.json",
      },
      -- remains visible even if other settings would normally hide it
      always_show = {
        --".gitignored",
      },
      -- remains hidden even if visible is toggled to true, this overrides always_show
      never_show = {
        --".DS_Store",
        --"thumbs.db"
      },
      -- uses glob style patterns
      never_show_by_pattern = {
        --".null-ls_*",
      },
    },
    follow_current_file = {
      -- This will find and focus the file in the active buffer every time
      enabled = true,
      -- the current file is changed while the tree is open.
      -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      leave_dirs_open = false,
    },
    -- when true, empty folders will be grouped together
    group_empty_dirs = false,
    -- netrw disabled, opening a directory opens neo-tree
    hijack_netrw_behavior = 'open_default',
    -- in whatever position is specified in window.position
    -- netrw disabled, opening a directory opens within the
    -- "open_current",
    -- window like netrw would, regardless of window.position
    -- netrw left alone, neo-tree does not handle opening dirs
    -- "disabled",
    -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
        ['I'] = 'toggle_hidden',
        ['/'] = 'fuzzy_finder',
        ['D'] = 'fuzzy_finder_directory',
        -- fuzzy sorting using the fzy algorithm
        ['#'] = 'fuzzy_sorter',
        -- ["D"] = "fuzzy_sorter_directory",
        ['e'] = 'filter_on_submit',
        ['<c-e>'] = 'clear_filter',
        ['<space>gk'] = 'prev_git_modified',
        ['<space>gj'] = 'next_git_modified',
        ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
        ['oc'] = { 'order_by_created', nowait = false },
        ['od'] = { 'order_by_diagnostics', nowait = false },
        ['og'] = { 'order_by_git_status', nowait = false },
        ['om'] = { 'order_by_modified', nowait = false },
        ['on'] = { 'order_by_name', nowait = false },
        ['os'] = { 'order_by_size', nowait = false },
        ['ot'] = { 'order_by_type', nowait = false },
      },
      -- define keymaps for filter popup window in fuzzy_finder_mode
      fuzzy_finder_mappings = {
        ['<c-j>'] = 'move_cursor_down',
        ['<c-k>'] = 'move_cursor_up',
      },
    },

    -- Add a custom command or override a global one using the same function name
    commands = {},
  },
  buffers = {
    follow_current_file = {
      -- This will find and focus the file in the active buffer every time
      enabled = true,
      -- the current file is changed while the tree is open.
      -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      leave_dirs_open = false,
    },
    -- when true, empty folders will be grouped together
    group_empty_dirs = true,
    show_unloaded = true,
    window = {
      mappings = {
        ['bd'] = 'buffer_delete',
        ['<bs>'] = 'navigate_up',
        ['.'] = 'set_root',
        ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
        ['oc'] = { 'order_by_created', nowait = false },
        ['od'] = { 'order_by_diagnostics', nowait = false },
        ['om'] = { 'order_by_modified', nowait = false },
        ['on'] = { 'order_by_name', nowait = false },
        ['os'] = { 'order_by_size', nowait = false },
        ['ot'] = { 'order_by_type', nowait = false },
      },
    },
  },
  git_status = {
    window = {
      position = 'float',
      mappings = {
        ['A']  = 'git_add_all',
        ['gu'] = 'git_unstage_file',
        ['ga'] = 'git_add_file',
        ['gr'] = 'git_revert_file',
        ['gc'] = 'git_commit',
        ['gp'] = 'git_push',
        ['gg'] = 'git_commit_and_push',
        ['o']  = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
        ['oc'] = { 'order_by_created', nowait = false },
        ['od'] = { 'order_by_diagnostics', nowait = false },
        ['om'] = { 'order_by_modified', nowait = false },
        ['on'] = { 'order_by_name', nowait = false },
        ['os'] = { 'order_by_size', nowait = false },
        ['ot'] = { 'order_by_type', nowait = false },
      },
    },
  },
}

require 'gep.utils'.register_maps {
  { 'n', '<space>e', ':Neotree toggle<cr>' },
}
