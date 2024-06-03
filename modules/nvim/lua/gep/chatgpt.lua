local chatgpt = require 'chatgpt'

chatgpt.setup {
  api_key_cmd = 'cat /run/openai-token',
}

require 'gep.utils'.register_maps {
  { 'n', '<space>ő', chatgpt.openChat },
}
