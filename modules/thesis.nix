self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      zotero
    ];

  # TODO: remove after zotero updates their firefox
  nixpkgs.config.permittedInsecurePackages = [
    "firefox-esr-140-bin-unwrapped-140.17.0esr"
  ];
}
