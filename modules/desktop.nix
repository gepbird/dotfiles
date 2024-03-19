self: { ... }:

{
  services.picom.enable = true;

  programs.slock.enable = true;

  hm-gep.services.dunst.enable = true;

  programs.dconf.enable = true;

  hm-gep.xdg.mimeApps.enable = true;
}
