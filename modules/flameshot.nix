self: { pkgs, ... }:

{
  hm.services.flameshot = {
    enable = true;
    # TODO: remove override when fixed: https://github.com/flameshot-org/flameshot/issues/2768
    package = pkgs.flameshot.overrideAttrs (o: {
      patches = o.patches ++ [
        (pkgs.fetchpatch {
          url = "https://github.com/gepbird/flameshot/commit/d48d1860244b7a1b9b0c7970c96441a08054a526.patch";
          hash = "sha256-jfy8vkPiPVhqfOpDOTnOco+hFNyfXv4An5kJZhM7BuU=";
        })
      ];
    });
    settings = {
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
