self:
{
  pkgs,
    ...
}:

{
  hm-gep.home.packages = with pkgs; [
    cargo
    cargo-watch
    lldb
    rust-analyzer
    rustc
    rustfmt
  ];
}
