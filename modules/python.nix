self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      pyright
      ruff
    ]
    ++ [
      (python3.withPackages (
        ps:
        with ps;
        self.lib.maybeCachePackages self [
          debugpy
          pip
        ]
      ))
    ];
}
