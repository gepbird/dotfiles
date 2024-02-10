{ ... }:

{
  services.geoclue2.enable = true;

  hm.services.gammastep = {
    provider = "geoclue2";
    enable = true;
    temperature = {
      day = 4000;
      night = 2700;
    };
  };
}
