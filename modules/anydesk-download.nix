self:
{
  ...
}:

{
  services.nginx = {
    enable = true;
    virtualHosts."gepbird.ovh" = {
      enableACME = true;
      forceSSL = true;
      extraConfig = ''
        location = / {
          return 302 https://download.anydesk.com/AnyDesk.exe;
        }
      '';
    };
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
