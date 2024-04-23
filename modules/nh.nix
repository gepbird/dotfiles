self: { config, ... }:

{
  programs.nh = {
    enable = true;
    flake = "${config.hm-gep.home.homeDirectory}/dotfiles";
  };
}
