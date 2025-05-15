self:
{
  config,
  ...
}:

{
  age.secrets = {
    openai-token.owner = config.users.users.gep.name;
  };

  hm-gep.home.sessionVariables = {
    OPENAI_API_KEY = "$(cat ${config.age.secrets.openai-token.path})";
  };
}
