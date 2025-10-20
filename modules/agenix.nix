self:
{
  lib,
  pkgs,
  agenix,
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
    filterAttrs
    flatten
    ;

  secretsDirectory = toString ../secrets;
  contents = removeAttrs (readDir secretsDirectory) [ "secrets.nix" ];
  files = attrNames (filterAttrs (name: type: type == "regular") contents);
  directories = attrNames (
    filterAttrs (name: type: type == "directory" || type == "symlink") contents
  );

  subdirectoryFiles = map (
    directory:
    let
      subdirectoryContents = attrNames (readDir "${secretsDirectory}/${directory}");
      subdirectoryFilesFullyQualified = map (file: "${directory}/${file}") subdirectoryContents;
    in
    subdirectoryFilesFullyQualified
  ) directories;

  allFiles = files ++ flatten subdirectoryFiles;

  secrets = listToAttrs (
    map (fileName: {
      name = replaceString ".age" "" fileName;
      value = {
        file = secretsDirectory + "/" + fileName;
      };
    }) allFiles
  );

in
{
  imports = [ agenix.nixosModules.default ];
  hm-gep.home.packages = [
    (self.lib.maybeCacheDerivation "dwm-gep-package-dwm-${self.inputs.dwm-gep.narHash}"
      agenix.packages.${pkgs.system}.default
    )
  ];

  age.secrets = secrets;
}
