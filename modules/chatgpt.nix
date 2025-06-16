self:
{
  config,
  pkgs,
  ...
}:

{
  age.secrets = {
    openai-token.owner = config.users.users.gep.name;
  };

  hm-gep.home.sessionVariables = {
    OPENAI_API_KEY = "$(cat ${
      config.age.secrets.openai-token.path
        or (toString (pkgs.writeText "openai-token" "SECRET_DOESNT_EXIST"))
    })";
  };
}
