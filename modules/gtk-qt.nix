self: { config, pkgs, ... }:

{
  # gtk3
  hm-gep.gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-error-bell = false;
    };
  };

  # gtk4
  hm-gep.xdg.configFile."gtk-4.0/gtk.css".source =
    config.hm-gep.lib.file.mkOutOfStoreSymlink
      # this gtk4 css tries to import gtk3/libadwaita.css that breaks some styles
      # I deliberately didn't link that gtk3 css, so it won't be loaded and won't break styles
      "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-4.0/gtk.css";

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
