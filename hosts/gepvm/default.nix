{ self, lib, ... }:

{
  imports = [ ./hardware.nix ] ++
    self.nixosModules.allImportsExcept [
      "chatgpt"
      "clac"
      "direnv"
      "discord"
      "feh"
      "flutter"
      "games"
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

  networking.hostName = "gepvm";
}
