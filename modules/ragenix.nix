self:
{
  lib,
  pkgs,
  ragenix,
  ...
}:

let
  inherit (builtins)
    attrNames
    listToAttrs
    readDir
    removeAttrs
    ;

  inherit (lib)
    replaceString
    ;

  secretsFolder = toString ../secrets;
  secretFileNames = attrNames (removeAttrs (readDir secretsFolder) [ "secrets.nix" ]);

  secrets = listToAttrs (
    map (fileName: {
      name = replaceString ".age" "" fileName;
      value = {
        file = secretsFolder + "/" + fileName;
      };
    }) secretFileNames
  );

in
{
  imports = [ ragenix.nixosModules.default ];
  hm-gep.home.packages = [ pkgs.ragenix ];

  age.secrets = secrets;
}
