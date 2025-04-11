self:
{
  agenix,
  pkgs,
  ...
}:

let
  inherit (builtins)
    attrNames
    listToAttrs
    readDir
    removeAttrs
    replaceStrings
    ;

  secretsFolder = toString ../secrets;
  secretFileNames = attrNames (removeAttrs (readDir secretsFolder) [ "secrets.nix" ]);

  secrets = listToAttrs (
    map (fileName: {
      name = replaceStrings [ ".age" ] [ "" ] fileName;
      value = {
        file = secretsFolder + "/" + fileName;
      };
    }) secretFileNames
  );

in
{
  imports = [ agenix.nixosModules.default ];
  hm-gep.home.packages = [ agenix.packages.${pkgs.system}.default ];

  age.secrets = secrets;
}
