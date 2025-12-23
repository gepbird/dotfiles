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
    "gep/ai-api-keys/openai".owner = config.users.users.gep.name;
    "gep/ai-api-keys/gemini".owner = config.users.users.gep.name;
  };

  hm-gep.home.sessionVariables = {
    OPENAI_API_KEY = "$(cat ${config.secrets.gep.ai-api-keys.openai or stub})";
    GEMINI_API_KEY = "$(cat ${config.secrets.gep.ai.api-keys.gemini or stub})";
  };
}
