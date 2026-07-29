self:
{
  config,
  lib,
  home-manager,
  pkgs,
  ...
}:

{
  imports = [
    home-manager.nixosModules.default
    (lib.mkAliasOptionModule
      [ "hm-gep" ]
      [
        "home-manager"
        "users"
        "gep"
      ]
    )
  ];
  home-manager = {
    backupCommand = lib.getExe pkgs.trash-cli;
    useGlobalPkgs = true;

    users.gep = {
      home.stateVersion = config.system.stateVersion;
    };
  };
}
