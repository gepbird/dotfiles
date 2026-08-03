self:
{
  pkgs,
  ...
}:

{
  programs.nix-ld = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.nix-ld;
    libraries =
      with pkgs;
      let
        python-deps = [
          stdenv.cc.cc.lib
        ];
      in
      self.lib.maybeCachePackages self python-deps;
  };
}
