# public key: "cache.gepbird.ovh-1:3+1oLReKrK2xdXCcIgei+fdmP/F0+UYZA1uOMbVzWzE="
self:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  enableServing = config.networking.hostName == "geptop-xmg" && config.enableSecrets;
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

  nix.settings.secret-key-files =
    lib.optional config.enableSecrets
      config.secrets.gep."cache.gepbird.ovh-1.sec";
}
