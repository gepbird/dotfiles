require 'flutter-tools'.setup {
  ui = {
    border = 'rounded',
  },
  decorations = {
    statusline = {
      app_version = false,
      device = false,
    },
  },
  debugger = {
    enabled = true,
    run_via_dap = true,
  },
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    enabled = true,
  },
  settings = {
    showTodos = false,
    completeFunctionCalls = true,
    renameFilesWithClasses = 'prompt',
    enableSnippets = true,
  },
}
