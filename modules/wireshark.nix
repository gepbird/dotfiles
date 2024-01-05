{ pkgs, ... }:

{
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.gep.extraGroups = [ "wireshark" ];
}
