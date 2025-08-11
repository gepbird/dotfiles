self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.cachePackages self [
      cargo
      cargo-watch
      lldb
      rust-analyzer
      rustc
      rustfmt
    ];
}
