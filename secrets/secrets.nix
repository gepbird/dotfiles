let
  pkgs = import <nixpkgs> { };
  lib = pkgs.lib;

  inherit (builtins)
    attrNames
    listToAttrs
    readDir
    removeAttrs
    ;

  inherit (lib)
    filterAttrs
    flatten
    ;

  ssh-module = import ../modules/ssh.nix null { };
  keys = ssh-module.users.users.gep.openssh.authorizedKeys.keys;

  secretsDirectory = toString ./.;
  contents = removeAttrs (readDir secretsDirectory) [ "secrets.nix" ];
  files = attrNames (filterAttrs (name: type: type == "regular") contents);
  directories = attrNames (filterAttrs (name: type: type == "directory") contents);

  subdirectoryFiles = map (
    directory:
    let
      subdirectoryContents = attrNames (readDir "${secretsDirectory}/${directory}");
      subdirectoryFilesFullyQualified = map (file: "${directory}/${file}") subdirectoryContents;
    in
    subdirectoryFilesFullyQualified
  ) directories;

  allFiles = files ++ flatten subdirectoryFiles;

  result = listToAttrs (
    map (x: {
      name = x;
      value = {
        publicKeys = keys;
      };
    }) allFiles
  );
in
result
