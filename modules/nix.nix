self: { config, pkgs, ... }:

{
  hm-gep.home.packages = with pkgs; [
    nix-diff
    nix-index
    nix-output-monitor
    nix-prefetch-git
    nixpkgs-review
    nvd
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "repl-flake"
    ];
    trusted-users = [ "gep" ];
    substituters = [
      "ssh://gep@192.168.1.248" # geptop
      "ssh://gep@192.168.1.183" # geppc
    ];
  };

  nix.sshServe = {
    enable = true;
    keys = config.users.users.gep.openssh.authorizedKeys.keys;
  };
}
