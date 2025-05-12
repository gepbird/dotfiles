# Read all files and folders in the current directory and convert them into nixosModules
# A utility function to import everything except some specified modules is also included
# Example output:
# {
#   games = import /nix/store/xxxx-source/modules/games.nix;
#   nvim = import /nix/store/xxxx-source/modules/nvim;
#   allImportsExcept = <LAMBDA [ "games" ] -> [ import .../nvim ]>;
# }

self:
let
  inherit (builtins)
    attrNames
    removeAttrs
    readDir
    listToAttrs
    replaceStrings
    attrValues
    ;

  modulesDir = toString ./.;

  filesAndDirectories = attrNames (removeAttrs (readDir modulesDir) [ "default.nix" ]);

  allModules = listToAttrs (
    map (name: {
      name = replaceStrings [ ".nix" ] [ "" ] name;
      value = import "${modulesDir}/${name}" self;
    }) filesAndDirectories
  );

  allImportsExcept = exceptions: attrValues (removeAttrs allModules exceptions);
in
allModules
// {
  inherit allImportsExcept;
}
