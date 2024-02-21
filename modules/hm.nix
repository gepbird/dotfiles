{ config, lib, ... }:

{
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
  ];

  home-manager.useGlobalPkgs = true;

  home-manager.users.gep = {
    home.stateVersion = config.system.stateVersion;
  };
}
