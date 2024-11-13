self:
{
  pkgs,
  ...
}:

{
  hm-gep.services.flameshot = {
    enable = true;
    # TODO: remove override when fixed: https://github.com/flameshot-org/flameshot/issues/2768
    package = pkgs.flameshot.overrideAttrs (o: {
      patches = o.patches ++ [
        (pkgs.fetchpatch {
          url = "https://github.com/gepbird/flameshot/commit/21cae1eae9ae116ac97a65b1b0494b91413ac423.patch";
          hash = "sha256-gYQDXZeKO5GUxQ6KcPP+EYN9l1zZlNLsKjTCVFsrmtE=";
        })
      ];
    });
    settings = {
      General = {
        disabledTrayIcon = true;
        predefinedColorPaletteLarge = true;
        showHelp = false;
      };
      Shortcuts = {
        TYPE_ARROW = "a";
        TYPE_MARKER = "ctrl+m";
        TYPE_PIXELATE = "b";
        TYPE_CIRCLE = "c";
        TYPE_CIRCLECOUNT = "x"; # incrmenting number bubble
        TYPE_SELECTION = "r"; # hollow rectangle
        TYPE_RECTANGLE = "shift+r"; # filled rectangle
        TYPE_MOVESELECTION = "m";
        TYPE_MOVE_LEFT = "h";
        TYPE_MOVE_DOWN = "j";
        TYPE_MOVE_UP = "k";
        TYPE_MOVE_RIGHT = "l";
        TYPE_RESIZE_LEFT = "ctrl+h";
        TYPE_RESIZE_DOWN = "ctrl+j";
        TYPE_RESIZE_UP = "ctrl+k";
        TYPE_RESIZE_RIGHT = "ctrl+l";
        TYPE_UNDO = "u";
        TYPE_REDO = "shift+u";
        TYPE_COPY = "y";
        TYPE_PIN = "return";
      };
    };
  };
}
