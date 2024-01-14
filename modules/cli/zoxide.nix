{ hm, ... }:

{
  hm.programs.zoxide = {
    enable = true;
    options = [ "--cmd j" ];
  };
}
