self:
{
  pkgs,
  lib,
  ...
}:

{
  programs.steam = {
    enable = true;
  };

  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      heroic
      hytale-launcher
      nur.repos.gepbird.mint-mod-manager
      osu-lazer-bin
      prismlauncher
      r2modman
      wineWow64Packages.staging
      winetricks
    ];

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        desiredgov = "performance";
        defaultgov = "powersave";
      };
      custom = {
        start = "${lib.getExe' pkgs.dunst "dunstify"} 'GameMode started'";
        end = "${lib.getExe' pkgs.dunst "dunstify"} 'GameMode ended'";
      };
    };
  };

  hm-gep.programs.mangohud = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.mangohud;
    enableSessionWide = true;
    settings = {
      cpu_temp = true;
      gamemode = true;
      gpu_temp = true;
      io_read = true;
      io_write = true;
      no_display = true;
      ram = true;
      swap = true;
      vram = true;
      vulkan_driver = true;
      wine = true;
      winesync = true;
    };
  };
}
