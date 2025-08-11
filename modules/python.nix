self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      pyright
      (python3.withPackages (
        ps: with ps; [
          debugpy
          pip
        ]
      ))
      ruff
    ];
}
