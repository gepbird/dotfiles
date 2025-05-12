self:
{
  config,
  ...
}:

{
  age.secrets = {
    openai-token.owner = config.users.users.gep.name;
  };
}
