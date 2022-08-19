require 'user.utils'.register_autocmd {
  'FileType',
  function() vim.cmd 'setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2' end,
  { pattern = 'python' },
}

return {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'on',
      },
    },
  },
}
