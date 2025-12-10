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
  age.secrets = {
    openai-api-key.owner = config.users.users.gep.name;
  };

  hm-gep.home.sessionVariables = {
    OPENAI_API_KEY = "$(cat ${config.age.secrets.openai-api-key.path or stub})";
  };
}
