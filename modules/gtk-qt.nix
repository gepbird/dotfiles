self: { config, pkgs, ... }:

{
  hm-gep.gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-error-bell = false;
    };
    gtk4.extraConfig = {
      gtk-error-bell = false;
    };
  };

  # dark theme for libadwaita (mostly/only gtk4?)
  environment.sessionVariables = {
    ADW_DISABLE_PORTAL = 1; # use color-scheme from dconf rather than from portal
  };
  hm-gep.dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
