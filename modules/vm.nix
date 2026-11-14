self:
{
  config,
  ...
}:

{
  virtualisation.vmVariant = {
    enableSecrets = false;
    services.displayManager.autoLogin = {
      enable = true;
      user = config.users.users.gep.name;
    };
    virtualisation = {
      cores = if config.networking.hostName == "geptop-xmg" then 16 else 4;
      diskSize = 1024 * 10;
      memorySize = 4 * 1024;
      resolution = {
        x = 1920;
        y = 1080;
      };
      qemu.options = [
        "-vga none"
        "-device virtio-vga"
        "-display gtk,zoom-to-fit=on,grab-on-hover=on"
      ];
    };
  };
}
