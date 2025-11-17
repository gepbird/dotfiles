self:
{
  pkgs,
  ...
}:

{
  services.nginx = {
    enable = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "gutyina.gergo.2@gmail.com";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
