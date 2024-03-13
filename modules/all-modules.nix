# Read all files in the current directory and convert them into nixosModules
# Example output:
# {
#   "firefox" = import /nix/store/xxxx-source/modules/firefox.nix;
#   "nvim" = import /nix/store/xxxx-source/modules/nvim;
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
in
allModules
