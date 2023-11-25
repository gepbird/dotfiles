-- see ~/.omnisharp/omnisharp.json
return {
  cmd = { 'OmniSharp' },
  handlers = {
    ['textDocument/definition'] = require 'omnisharp_extended'.handler,
  },
}
