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

      # TODO: remove when fixed: https://github.com/nix-community/home-manager/issues/2064
      # workaround for 'Failed to restart flameshot.service: Unit tray.target not found.'
      systemd.user.targets.tray = {
        Unit = {
          Description = "Home Manager System Tray";
          Requires = [ "graphical-session-pre.target" ];
        };
      };
    };
  };
}
