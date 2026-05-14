{
  ...
}:

{
  services.nginx = {
    enable = true;
  };

  security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
