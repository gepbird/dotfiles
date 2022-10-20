return {
  handlers = {
    ['textDocument/definition'] = require 'omnisharp_extended'.handler,
  },
  enable_editorconfig_support = true,
  enable_roslyn_analyzers = false,
  organize_imports_on_format = true,
  enable_import_completion = true,
}
