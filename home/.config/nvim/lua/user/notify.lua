local notify = require 'notify'
vim.notify = function(message, level, opts)
  -- Disable this message from netcoredbg
  if message == 'The breakpoint is pending and will be resolved when debugging starts.' then
    return
  end
  notify.notify(message, level, opts)
end
notify.setup {
  level = vim.log.levels.INFO,
  timeout = 4000,
}

require 'telescope'.load_extension 'notify'
