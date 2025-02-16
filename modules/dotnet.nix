self:
{
  pkgs,
    ...
}:

let
  jsonFormat = pkgs.formats.json { };
in
{
  hm-gep.home.packages = with pkgs; [
    netcoredbg
    omnisharp-roslyn
    dotnet-sdk
  ];

  hm-gep.home.file.".omnisharp/omnisharp.json".source = jsonFormat.generate "omnisharp.json" {
    RoslynExtensionsOptions = {
      EnableDecompilationSupport = true;
    };
  };

  hm-gep.home.sessionVariables = {
    DOTNET_ROOT = pkgs.dotnet-sdk;
  };
}
