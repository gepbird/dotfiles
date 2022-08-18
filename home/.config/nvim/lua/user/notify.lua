local notify = require 'notify'
vim.notify = notify
notify.setup {
  level = 'WARN',
  timeout = 2000,
}

require 'telescope'.load_extension 'notify'
