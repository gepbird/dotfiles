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
    isFunction
    functionArgs
    ;

  modulesDir = toString ./.;

  filesAndDirectories = attrNames (removeAttrs (readDir modulesDir) [ "default.nix" ]);

  # Most module files are plain NixOS modules (`{ pkgs, ... }: ...`). A few need
  # this flake's own `self` (e.g. for `self.lib` or `self.inputs`) and are
  # written as `self: { pkgs, ... }: ...` instead. We only apply `self` to the
  # latter, detected by `functionArgs` reporting no named arguments - a bare
  # `self:` is a plain-identifier lambda, whereas a real module has named
  # formals (`pkgs`, `config`, ...). This way modules that don't need `self`
  # don't have to carry a dead `self:` wrapper.
  #
  # `self` must stay a closure baked in here rather than a normal module arg
  # (`{ self, pkgs, ... }:`), because specialArgs always wins over anything a
  # module sets via `config._module.args`. Since any flake that reuses one of
  # our nixosModules passes its *own* `self` via specialArgs, a module-arg
  # `self` would silently resolve to the consuming flake's self instead of
  # ours (see raspi-dotfiles).
  importModule =
    path:
    let
      value = import path;
    in
    if isFunction value && functionArgs value == { } then value self else value;

  allModules = listToAttrs (
    map (name: {
      name = replaceStrings [ ".nix" ] [ "" ] name;
      value = importModule "${modulesDir}/${name}";
    }) filesAndDirectories
  );

  allImportsExcept = exceptions: attrValues (removeAttrs allModules exceptions);
in
allModules
// {
  inherit allImportsExcept;
}
