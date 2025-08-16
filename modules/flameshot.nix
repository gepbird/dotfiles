self:
{
  ...
}:

{
  hm-gep.services.flameshot = {
    enable = true;
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
