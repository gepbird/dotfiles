self:
{
  config,
  ...
}:

{
  hm-gep.programs.nh = {
    enable = true;
    flake = "${config.hm-gep.home.homeDirectory}/dotfiles";
  };
}
