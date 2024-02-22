{ ... }:

{
  # This function expects this repository to be at ~/dotfiles
  mkDotfilesSymlink = config: pathFromHome:
    config.hm.lib.file.mkOutOfStoreSymlink
      "${config.hm.home.homeDirectory}/dotfiles/${pathFromHome}";
}
