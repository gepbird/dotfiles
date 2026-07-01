self:
{
  config,
  lib,
  ...
}:

{
  sops.secrets = {
    "gep/work/sshconfig".owner = config.users.users.gep.name;
  };

  hm-gep.programs.ssh = {
    includes = lib.optionals config.enableSecrets [
      config.secrets.gep.work.sshconfig
    ];
  };
}
