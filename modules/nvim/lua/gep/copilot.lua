if vim.fn.hostname() == 'gepvm' then
  return
end

require 'copilot'.setup {
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = false,
  },
}

-- used in blink-cmp.lua
