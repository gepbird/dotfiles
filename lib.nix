{
  ...
}:

{
  # This function expects this repository to be at ~/dotfiles
  mkDotfilesSymlink =
    config: pathFromHome:
    config.hm-gep.lib.file.mkOutOfStoreSymlink "${config.hm-gep.home.homeDirectory}/dotfiles/${pathFromHome}";
}
