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
      "onlyoffice"
      "opentabletdriver"
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

  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    efi.canTouchEfiVariables = lib.mkForce false;
    grub = {
      enable = true;
      device = "/dev/vda";
    };
  };

  networking.hostName = "gepvm";
}
