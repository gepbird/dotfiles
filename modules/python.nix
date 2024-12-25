self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = with pkgs; [
    (python3.withPackages (
      ps:
      with ps;
      [
        pip
        debugpy
        python-lsp-server
      ]
      ++ python-lsp-server.optional-dependencies.yapf
    ))
  ];
}
