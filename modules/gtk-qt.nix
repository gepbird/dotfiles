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

  environment.sessionVariables = {
    # some gtk3 apps like pavucontrol and lightdm only work with this
    GTK_THEME = "Adwaita:dark";
    # dark theme for libadwaita (mostly/only gtk4?)
    ADW_DISABLE_PORTAL = 1; # use color-scheme from dconf rather than from portal
  };
  hm-gep.dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  qt = {
    # disable due to packet tracer looking bad with half light, half dark theme
    enable = false;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
