self:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  enableServing = config.networking.hostName == "geptop-xmg";
in
{
  services.nix-serve = {
    enable = enableServing;
    package = self.lib.maybeCachePackage self pkgs.nix-serve-ng;
    secretKeyFile = lib.head config.nix.settings.secret-key-files;
  };

  services.nginx.virtualHosts."cache.gepbird.ovh" = lib.mkIf enableServing {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.nix-serve.port}";
      recommendedProxySettings = true;
    };
  };

  nix.settings = {
    substituters = [
      # uses cache.gepbird.ovh safely (without failing if it is offline)
      # https://github.com/tchfoo/raspi-dotfiles/commit/53406a458478f227f5fd0810684a39aff098dfa7
      "https://nix-cache.tchfoo.com" 
    ];
    trusted-public-keys = [
      "nix-cache.tchfoo.com-1:pWK4l0phRA3bE0CviZodEQ5mWAQYoiuVi2LML+VNtNY="
    ];
    secret-key-files = [
      config.secrets.gep."nix-cache.tchfoo.com-1.sec"
    ];
  };
}
