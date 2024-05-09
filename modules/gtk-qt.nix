self: { ... }:

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
  environment.sessionVariables.GTK_THEME = "Adwaita-dark";

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
