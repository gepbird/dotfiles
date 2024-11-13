self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages = [ pkgs.xfce.xfce4-terminal ];
  programs.xfconf.enable = true;
  hm-gep.xfconf = {
    enable = true;
    settings = {
      xfce4-terminal = {
        color-background = "#202020";
        color-foreground = "#dcdcdc";
        # dark gruvbox color scheme
        color-palette = "rgb(40,40,40);rgb(204,36,29);rgb(152,151,26);rgb(215,153,33);rgb(69,133,136);rgb(177,98,134);rgb(104,157,106);rgb(168,153,132);rgb(112,144,128);rgb(251,73,52);rgb(184,187,38);rgb(250,189,47);rgb(131,165,152);rgb(211,134,155);rgb(142,192,124);rgb(235,219,178)";
        misc-confirm-close = false;
        misc-highlight-urls = true;
        misc-middle-click-opens-uri = true;
        misc-menubar-default = false;
        misc-show-unsafe-paste-dialog = false;
        misc-use-shift-arrow-to-scroll = true;
        scrolling-unlimited = true;
      };
    };
  };
}
