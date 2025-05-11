{
  self,
  lib,
  pkgs,
  ...
}:

{
  imports =
    [ ./hardware.nix ]
    ++ self.nixosModules.allImportsExcept [
      "adb"
      "arduino"
      "at"
      "c"
      "chatgpt"
      "clac"
      "config-formats"
      "direnv"
      "discord"
      "dotnet"
      "droidcam"
      "ente-auth"
      "feh"
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
      "matlab"
      "mpv"
      "nvidia"
      "obs-studio"
      "onlyoffice"
      "opentabletdriver"
      "packettracer"
      "php"
      "piper"
      "polkit"
      "python"
      "rnote"
      "rust"
      "virt-manager"
      "vmware"
      "vscode"
      "webdev"
      "wireshark"
      "zathura"
    ];

  boot.loader.grub = {
    efiSupport = lib.mkForce false;
    device = lib.mkForce "/dev/vda";
  };

  age.secrets = {
    system-password.file = lib.mkForce (
      pkgs.writeText "$6$Z6Mge73J$mBdqB5EcjwEb/QifNdBPVyVgeIz6hL4RQpDGACssXrCShUkVyEdehBAzPEltCfNXZof5Icg3aRoRa3nlaPtAH." "system-password"
    );
    openai-token.file = lib.mkForce (pkgs.writeText "" "openai-token");
  };

  networking.hostName = "gepvm";

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  system.stateVersion = "23.05";
}
