self:
{
  lib,
  pkgs,
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
  imports = [ self.inputs.agenix.nixosModules.default ];

  nixpkgs.overlays = [ self.inputs.agenix.overlays.default ];

  hm-gep.home.packages = with pkgs; [
    (self.lib.maybeCacheDerivation "agenix-package-agenix-${self.inputs.agenix.narHash}-nixpkgs-overlayed-${self.inputs.nixpkgs.narHash}" agenix)
  ];

  age.secrets = secrets;
}
