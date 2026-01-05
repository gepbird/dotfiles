self:
{
  config,
  pkgs,
  ...
}:

let
  stub = toString (pkgs.writeText "secret-stub" "SECRET_DOESNT_EXIST");
in
{
  sops.secrets = {
    "gep/ai-api-keys/gemini".owner = config.users.users.gep.name;
    "gep/ai-api-keys/openrouter".owner = config.users.users.gep.name;
  };

  hm-gep.home.sessionVariables = {
    GEMINI_API_KEY = "$(cat ${config.secrets.gep.ai-api-keys.gemini or stub})";
    OPENROUTER_API_KEY = "$(cat ${config.secrets.gep.ai-api-keys.openrouter or stub})";
  };
}
