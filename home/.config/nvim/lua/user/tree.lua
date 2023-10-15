local api = require 'nvim-tree.api'

require 'nvim-tree'.setup {
  hijack_cursor = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        git = {
          unstaged = 'M',
          staged = 'S',
          unmerged = '',
          renamed = 'R',
          deleted = 'D',
          untracked = 'U',
          ignored = '◌',
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  modified = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    custom = { '\\.git$' },
  },
  on_attach = function(bufnr)
    require 'user.utils'.register_maps {
      { 'n', '<s-o>',    api.node.open.no_window_picker,     { buffer = bufnr, nowait = true } },
      { 'n', 'c',        api.tree.change_root_to_node,       { buffer = bufnr, nowait = true } },
      { 'n', '<c-v>',    api.node.open.vertical,             { buffer = bufnr, nowait = true } },
      { 'n', '<c-x>',    api.node.open.horizontal,           { buffer = bufnr, nowait = true } },
      { 'n', '<c-t>',    api.node.open.tab,                  { buffer = bufnr, nowait = true } },
      { 'n', '<s-p>',    api.node.navigate.parent,           { buffer = bufnr, nowait = true } },
      { 'n', 'h',        api.node.navigate.parent_close,     { buffer = bufnr, nowait = true } },
      { 'n', 'l',        api.node.open.edit,                 { buffer = bufnr, nowait = true } },
      { 'n', '<s-h>',    api.tree.collapse_all,              { buffer = bufnr, nowait = true } },
      { 'n', '<s-l>',    api.tree.expand_all,                { buffer = bufnr, nowait = true } },
      { 'n', '<tab>',    api.node.open.preview,              { buffer = bufnr, nowait = true } },
      { 'n', '<s-i>',    api.tree.toggle_gitignore_filter,   { buffer = bufnr, nowait = true } },
      { 'n', '<s-u>',    api.tree.toggle_custom_filter,      { buffer = bufnr, nowait = true } },
      { 'n', '<s-r>',    api.tree.reload,                    { buffer = bufnr, nowait = true } },
      { 'n', 'a',        api.fs.create,                      { buffer = bufnr, nowait = true } },
      { 'n', '<s-d>',    api.fs.remove,                      { buffer = bufnr, nowait = true } },
      { 'n', 'd',        api.fs.trash,                       { buffer = bufnr, nowait = true } },
      { 'n', '<c-r>',    api.fs.rename,                      { buffer = bufnr, nowait = true } },
      { 'n', 'r',        api.fs.rename_sub,                  { buffer = bufnr, nowait = true } },
      { 'n', 'x',        api.fs.cut,                         { buffer = bufnr, nowait = true } },
      { 'n', 'y',        api.fs.copy.node,                   { buffer = bufnr, nowait = true } },
      { 'n', 'p',        api.fs.paste,                       { buffer = bufnr, nowait = true } },
      { 'n', '<c-y>',    api.fs.copy.relative_path,          { buffer = bufnr, nowait = true } },
      { 'n', '<s-y>',    api.fs.copy.absolute_path,          { buffer = bufnr, nowait = true } },
      { 'n', 'ő',        api.node.navigate.diagnostics.prev, { buffer = bufnr, nowait = true } },
      { 'n', 'á',        api.node.navigate.git.prev,         { buffer = bufnr, nowait = true } },
      { 'n', 'ú',        api.node.navigate.diagnostics.next, { buffer = bufnr, nowait = true } },
      { 'n', 'ű',        api.node.navigate.git.next,         { buffer = bufnr, nowait = true } },
      { 'n', '-',        api.tree.change_root_to_parent,     { buffer = bufnr, nowait = true } },
      { 'n', 's',        api.node.run.system,                { buffer = bufnr, nowait = true } },
      { 'n', 'f',        api.live_filter.start,              { buffer = bufnr, nowait = true } },
      { 'n', 'F',        api.live_filter.clear,              { buffer = bufnr, nowait = true } },
      { 'n', 'q',        api.tree.close,                     { buffer = bufnr, nowait = true } },
      { 'n', '<s-s>',    api.tree.search_node,               { buffer = bufnr, nowait = true } },
      { 'n', '.',        api.node.run.cmd,                   { buffer = bufnr, nowait = true } },
      { 'n', '<space>k', api.node.show_info_popup,           { buffer = bufnr, nowait = true } },
      { 'n', 'g?',       api.tree.toggle_help,               { buffer = bufnr, nowait = true } },
      { 'n', 'm',        api.marks.toggle,                   { buffer = bufnr, nowait = true } },
      { 'n', 'bmv',      api.marks.bulk.move,                { buffer = bufnr, nowait = true } },
    }
  end,
}

require 'user.utils'.register_maps {
  { 'n', '<space>e', function() api.tree.toggle { find_file = true } end },
}
