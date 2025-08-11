self:
{
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

  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      cachix
      hydra-check
      nix-diff
      nix-inspect
      nix-output-monitor
      nix-prefetch-git
      nix-tree
      nix-update
      nixd
      nixfmt
      nixpkgs-review
      nvd
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

  nix = {
    nixPath = [
      "nixpkgs=${nixpkgs}"
    ];
    settings =
      let
        caches = [
          {
            substituter = "https://nix-community.cachix.org";
            trusted-public-key = "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
          }
          {
            substituter = "https://cosmic.cachix.org";
            trusted-public-key = "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=";
          }
          {
            substituter = "https://gepbird-nur-packages.cachix.org";
            trusted-public-key = "gepbird-nur-packages.cachix.org-1:Ip2iveknanFBbJ2DFWk8cDomfRquUJiMWS/2fSeuMis=";
          }
        ];
      in
      {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = map (cache: cache.substituter) caches;
        trusted-public-keys = map (cache: cache.trusted-public-key) caches;
        trusted-users = [ "gep" ];
      };
  };

  nixpkgs.config.allowUnfree = true;
  hm-gep.home.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

  programs.nix-index-database.comma.enable = true;
}
