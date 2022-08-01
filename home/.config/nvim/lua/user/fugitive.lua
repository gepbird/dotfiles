local utils = require 'user.utils'

utils.register_autocommands('user_fugitive', {
  {
    'FileType',
    function()
      utils.register_maps {
        { 'nv', 'j', ')', { remap = true, buffer = true } },
        { 'nv', 'k', '(', { remap = true, buffer = true } },
        { 'nv', 'l', '<cr>', { remap = true, buffer = true } },
      }
    end,
    { pattern = 'fugitive' }
  }
})

utils.register_maps {
  { 'n', '<space>g<s-d>', ':G diff<cr>' },
  { 'n', '<space>g<c-d>', ':G diff --staged<cr>' },
  { 'n', '<space>go', ':GBrowse<cr>' },
  { 'n', '<space>gi', ':G<cr>' },
  { 'n', '<space>gl', ':G log<cr>' },
}
