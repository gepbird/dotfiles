{
  self,
  lib,
  ...
}:

{
  imports = [
    ./hardware.nix
  ]
  ++ self.nixosModules.allImportsExcept [
    "adb"
    "ai"
    "anydesk-download"
    "arduino"
    "at"
    "c"
    "clac"
    "config-formats"
    "direnv"
    "discord"
    "dotnet"
    "droidcam"
    "elixir"
    "ente-auth"
    "feh"
    "figma"
    "file-roller"
    "flameshot"
    "flutter"
    "games"
    "gromit-mpx"
    "gui"
    "java"
    "latex"
    "libreoffice"
    "light"
    "mpv"
    "network-bridge"
    "nvidia"
    "obs"
    "onlyoffice"
    "opentabletdriver"
    "packettracer"
    "php"
    "piper"
    "polkit"
    "python"
    "rnote"
    "rust"
    "thesis"
    "typst"
    "virt-manager"
    "vmware"
    "vscode"
    "webdev"
    "wireshark"
    "work"
    "zathura"
  ];

  boot.loader.grub = {
    efiSupport = lib.mkForce false;
    device = lib.mkForce "/dev/vda";
  };

  age.secrets = lib.mkForce { };

  networking.hostName = "gepvm";

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  system.stateVersion = "23.05";
}
