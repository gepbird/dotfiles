self:
{
  config,
  ...
}:

{
  virtualisation.vmVariant = {
    enableSecrets = false;
    virtualisation = {
      cores = if config.networking.hostName == "geptop-xmg" then 16 else 4;
      diskSize = 1024 * 10;
      memorySize = 4 * 1024;
    };
  };
}
