{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
    sha256 = "0dfshsgj93ikfkcihf4c5z876h4dwjds998kvgv7sqbfv0z6a4bc";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.gep = {
    home.stateVersion = "23.05";
    home.file = {
      ".config/nvim/ftplugin".source = ./home/.config/nvim/ftplugin;
      ".config/nvim/lua".source = ./home/.config/nvim/lua;
      ".config/nvim/init.lua".source = ./home/.config/nvim/init.lua;
      ".config/nvim/.luarc.json".source = ./home/.config/nvim/.luarc.json;
      ".omnisharp".source = ./home/.omnisharp;
    };
  };
}
