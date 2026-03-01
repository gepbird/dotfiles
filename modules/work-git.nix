self:
{
  config,
  lib,
  ...
}:

{
  sops.secrets = {
    "gep/work/gitconfig".owner = config.users.users.gep.name;
  };

  hm-gep.programs.git = {
    includes = lib.optional config.enableSecrets {
      condition = "gitdir:~/work/";
      path = config.secrets.gep.work.gitconfig;
    };
  };
}
