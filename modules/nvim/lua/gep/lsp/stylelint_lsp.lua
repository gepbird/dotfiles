return {
  cmd = {
    'stylelint-lsp',
    '--stdio',
  },
  -- TODO: remove when fixed: https://github.com/bmatcuk/stylelint-lsp/issues/39
  filetypes = {
    'css',
    'less',
    'scss',
    'sugarss',
    'vue',
    'wxss',
  },
}
