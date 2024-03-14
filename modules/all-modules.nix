# Read all files and folders in the current directory and convert them into nixosModules
# A utility function to import everything except some specified modules is also included
# Example output:
# {
#   "games" = import /nix/store/xxxx-source/modules/games.nix;
#   "nvim" = import /nix/store/xxxx-source/modules/nvim;
#   "allImportsExcept" = <LAMBDA [ "games" ] -> [ import .../firefox.nix ]>;
# }

let
  modulesDir = builtins.toString ./.;

  filesAndDirectories = builtins.attrNames
    (builtins.removeAttrs (builtins.readDir modulesDir) [ "all-modules.nix" "default.nix" ]);

  allModules = builtins.listToAttrs (
    map
      (name: {
        name = builtins.replaceStrings [ ".nix" ] [ "" ] name;
        value = import "${modulesDir}/${name}";
      })
      filesAndDirectories
  );

  allImportsExcept = exceptions: builtins.attrValues (builtins.removeAttrs allModules exceptions);
in
allModules //
{
  inherit allImportsExcept;
}
