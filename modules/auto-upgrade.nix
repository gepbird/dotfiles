self:
{
  config,
  ...
}:

{
  system.autoUpgrade = {
    enable = true;
    flake = "git+https://git.tchfoo.com/gepbird/dotfiles#${config.networking.hostName}";
    dates = "03:00";
    persistent = false;
    upgrade = false;
  };
}
