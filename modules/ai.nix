self:
{
  config,
  lib,
  pkgs,
  ...
}:

{
  sops.secrets = {
    "gep/ai-api-keys/gemini".owner = config.users.users.gep.name;
    "gep/ai-api-keys/openrouter".owner = config.users.users.gep.name;
  };

  hm-gep.home.sessionVariables = lib.optionalAttrs config.enableSecrets {
    GEMINI_API_KEY = "$(cat ${config.secrets.gep.ai-api-keys.gemini})";
    OPENROUTER_API_KEY = "$(cat ${config.secrets.gep.ai-api-keys.openrouter})";
  };
}
