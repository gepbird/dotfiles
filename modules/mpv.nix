{ ... }:

{
  hm.programs.mpv = {
    enable = true;
    config = {
      force-window = true; # open gui for audio-only
      keepaspect-window = false; # allow wm resize
    };
    bindings = {
      h = "seek -2 exact";
      H = "seek -30 exact";
      l = "seek 2 exact";
      L = "seek 30 exact";
      "?" = "multiply speed 1/1.1";
      ":" = "multiply speed 1.1";
      j = "add volume -5";
      k = "add volume 5";
      "Ctrl+l" = ''cycle-values loop-file "inf" "no"'';
    };
  };

  hm.xdg.mimeApps.defaultApplications = {
    "audio/vnd.wave" = [ "mpv.desktop" ];
    "audio/mpeg" = [ "mpv.desktop" ];
    "image/gif" = [ "mpv.desktop" ];
    "video/mp4" = [ "mpv.desktop" ];
  };
}
