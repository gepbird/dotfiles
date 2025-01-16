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
      "chatgpt"
      "clac"
      "direnv"
      "discord"
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
      "lsp"
      "matlab"
      "mpv"
      "nvidia"
      "onlyoffice"
      "opentabletdriver"
      "packettracer"
      "piper"
      "polkit"
      "python"
      "rnote"
      "sdk"
      "virt-manager"
      "vmware"
      "vscode"
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
}
