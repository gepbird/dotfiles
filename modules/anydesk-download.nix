self:
{
  pkgs,
  ...
}:

{
  services.nginx = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.nginx;
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

  security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
