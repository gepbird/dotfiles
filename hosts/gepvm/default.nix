{
  self,
  lib,
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
      "gitlab-runner"
      "gromit-mpx"
      "gui"
      "java"
      "latex"
      "libreoffice"
      "light"
      "matlab"
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

  age.secrets = lib.mkForce { };

  networking.hostName = "gepvm";

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  system.stateVersion = "23.05";
}
