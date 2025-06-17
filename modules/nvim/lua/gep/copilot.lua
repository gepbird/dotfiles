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

-- TODO: blink-cmp
--require 'copilot_cmp'.setup {
--}
