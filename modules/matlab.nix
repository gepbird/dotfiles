self: { pkgs, nix-matlab, ... }:

{
  # NOTE: MANUAL INSTALL REQUIRED FOR MATLAB:
  # prepare matlab folder: $ mkdir -p ~/.local/share/matlab
  # log in and download the linux installer zip from https://www.mathworks.com/downloads/web_downloads
  # extract and cd into it
  # go into a shell for matlab: $ nix run gitlab:doronbehar/nix-matlab#matlab-shell
  # (from the shell) start the GUI installer: $ ./install
  # (in the gui installer) install matlab to ~/.local/share/matlab/install
  # remove broken installer generated and modified files: $ rm ~/.local/share/applications/mimeapps.list ~/.local/share/applications/mw-*.desktop
  # rebuild your system to regenerate mimeapps.list and link files with home manager
  nixpkgs.overlays = [ nix-matlab.overlay ];

  hm-gep.home.packages = with pkgs; [
    matlab
  ];

  hm-gep.xdg.configFile."matlab/nix.sh" = {
    executable = true;
    text = "INSTALL_DIR=$HOME/.local/share/matlab/install";
  };
}
