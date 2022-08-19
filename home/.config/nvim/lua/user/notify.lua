local notify = require 'notify'
vim.notify = notify
notify.setup {
  level = 'WARN',
  timeout = 4000,
}

require 'telescope'.load_extension 'notify'
