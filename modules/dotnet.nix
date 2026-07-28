self:
{
  pkgs,
  ...
}:

let
  jsonFormat = pkgs.formats.json { };
in
{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      omnisharp-roslyn
      dotnet-sdk
    ];

  hm-gep.home.file.".omnisharp/omnisharp.json".source = jsonFormat.generate "omnisharp.json" {
    RoslynExtensionsOptions = {
      EnableDecompilationSupport = true;
    };
  };

  hm-gep.home.sessionVariables = {
    DOTNET_ROOT = self.lib.maybeCachePackage self pkgs.dotnet-sdk;
  };
}
