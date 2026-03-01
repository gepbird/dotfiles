self:
{
  config,
  pkgs,
  lib,
  nixpkgs,
  ...
}:

let
  inherit (lib)
    mapAttrsToList
    ;
  inherit (pkgs)
    writeShellScriptBin
    ;

  aliasFunctions = {
    bump = "nix-shell maintainers/scripts/update.nix --argstr skip-prompt true --argstr package $@";
    bumpc = "nix-shell maintainers/scripts/update.nix --argstr skip-prompt true --argstr commit true --argstr package $@";
    nb = "if [[ -e default.nix ]]; then nom build -f . $@; else nom build .#$@; fi";
    nd = "if [[ -e default.nix ]]; then nom develop -f . $@; else nom develop .#$@; fi";
    ne = "if [[ -e default.nix ]]; then nix eval -f . $@; else nix eval .#$@; fi";
    nr = "nix repl -f . $@";
  };
  aliasFunctionPackages = mapAttrsToList (
    alias: script: writeShellScriptBin alias script
  ) aliasFunctions;
in
{
  imports = [
    self.inputs.nix-index-database.nixosModules.nix-index
  ];

  # NOTE: these may not rebuild after changes to lix due to trace-cache, it shouldn't be a problem
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      cachix
      dix
      hydra-check
      nix-diff
      nix-eval-jobs
      nix-inspect
      nix-prefetch-git
      nix-tree
      nix-update
      nixd
      nixfmt
      nixpkgs-review
    ]
    ++ [
      nix-output-monitor
    ]
    ++ aliasFunctionPackages;

  nixpkgs.overlays = [
    (final: prev: {
      # https://github.com/maralorn/nix-output-monitor/issues/189
      nix-output-monitor = prev.nix-output-monitor.overrideAttrs (o: {
        patches = (o.patches or [ ]) ++ [
          (prev.fetchpatch2 {
            name = "dont-print-errors-and-traces.patch";
            url = "https://github.com/gepbird/nix-output-monitor/commit/30196c783f7c7904fb22ae943eed6ef6b39c8415.patch";
            hash = "sha256-wzLChhPT3tEqXlB0DlHekaNytTV1+13NXP4e6Fq5UQE=";
          })
        ];
      });
      # the above nom patch triggers an nh rebuild, make it faster
      nh = prev.nh.overrideAttrs {
        doCheck = false;
      };
    })
  ];

  sops.secrets = {
    "gep/nix-github-access-token".owner = config.users.users.gep.name;
  };

  nix = {
    nixPath = [
      "nixpkgs=${nixpkgs}"
    ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-cache.tchfoo.com"
      ];
      trusted-public-keys = [
        "nix-cache.tchfoo.com-1:pWK4l0phRA3bE0CviZodEQ5mWAQYoiuVi2LML+VNtNY="
      ];
      trusted-users = [
        "gep"
      ];
      warn-dirty = false;
      max-jobs = if config.networking.hostName == "geptop-xmg" then 8 else 4;
    };
    extraOptions = lib.mkIf config.enableSecrets ''
      !include ${config.secrets.gep.nix-github-access-token}
    '';
  };

  nix.sshServe = {
    enable = true;
    keys = config.users.users.gep.openssh.authorizedKeys.keys;
    protocol = "ssh-ng";
    trusted = true;
    write = true;
  };

  nixpkgs.config.allowUnfree = true;
  hm-gep.home.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

  programs.nix-index-database.comma.enable = true;

  documentation.nixos.enable = false;
}
