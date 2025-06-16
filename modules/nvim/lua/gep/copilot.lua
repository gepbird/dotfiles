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

require 'copilot_cmp'.setup {
}
