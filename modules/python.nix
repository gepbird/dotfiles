self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
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
