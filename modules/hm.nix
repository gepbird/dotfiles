self: { config, lib, home-manager, ... }:

{
  imports = [
    home-manager.nixosModules.default
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "gep" ])
  ];

  home-manager.useGlobalPkgs = true;

  home-manager.users.gep = {
    home.stateVersion = config.system.stateVersion;
  };
}
