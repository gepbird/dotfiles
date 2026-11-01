self:
{
  pkgs,
  ...
}:

{
  services.nginx.virtualHosts."the-missing-intel-naming-scheme.gepbird.ovh" = {
    enableACME = true;
    forceSSL = true;
    root =
      self.inputs.the-missing-intel-naming-scheme.packages.${pkgs.stdenv.hostPlatform.system}.default;
    extraConfig = ''
      error_page 404 /404.html;
    '';
    locations."/assets/".extraConfig = ''
      expires max;
      add_header Cache-Control "public, immutable";
    '';
  };
}
