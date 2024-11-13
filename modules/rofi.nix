self:
{
  pkgs,
  lib,
  ...
}:

{
  hm-gep.programs.rofi = {
    enable = true;
    theme = "gruvbox-dark-hard";
    terminal = lib.getExe pkgs.xfce.xfce4-terminal;
    extraConfig = {
      matching = "fuzzy";
      sort = true;

      kb-clear-line = "Control+c";
      kb-move-front = "Control+h,Home,KP_Home";
      kb-move-end = "Control+l,End,KP_End";
      kb-move-word-back = "Control+b,Control+Left";
      kb-move-word-forward = "Control+w,Control+Right";
      kb-move-char-back = "Alt+h,Left";
      kb-move-char-forward = "Alt+l,Right";
      kb-accept-entry = "Return";
      kb-accept-custom = "Control+Return"; # accept the exact command typed
      kb-accept-custom-alt = "Control+Shift+Return"; # accept the exact command typed and open in termin
      kb-accept-alt = "Shift+Return"; # open in terminal
      kb-mode-next = "Tab";
      kb-mode-previous = "ISO_Left_Tab"; # Shift+Tab
      kb-row-up = "Control+k,Control+p,Up";
      kb-row-down = "Control+j,Control+n,Down";
      kb-page-prev = "Control+u,Page_Up,KP_Page_Up";
      kb-page-next = "Control+d,Page_Down,KP_Page_Down";
      kb-row-first = "Control+g,Shift+Home,Shift+KP_Home";
      kb-row-last = "Control+G,Shift+End,Shift+KP_End";
      kb-cancel = "Escape";

      # remove some keys from default binds due to conflict
      kb-remove-char-forward = "Delete"; # remove Control+d
      kb-remove-char-back = "BackSpace,Shift+BackSpace"; # remove Control+h
      kb-remove-to-eol = ""; # remove Control+k
      kb-remove-to-sol = ""; # remove Control+u
      kb-mode-complete = ""; # remove Control+l
      kb-element-next = ""; # remove Tab
      kb-element-prev = ""; # remove Shift+Tab
    };
  };
}
