self:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  enableServing = config.networking.hostName == "geptop-xmg";
  proxyStorePort = 23945;
in
{
  services.nix-serve = {
    enable = enableServing;
    package = self.lib.maybeCachePackage self pkgs.nix-serve-ng;
    secretKeyFile = lib.head config.nix.settings.secret-key-files;
  };

  nix.settings = {
    substituters = [
      #"https://cache.gepbird.ovh"
      "http://localhost:${toString proxyStorePort}"
    ];
    trusted-public-keys = [
      "cache.gepbird.ovh-1:/2wN3bgUOBBp2e2a7Rj2hieqdyL0fEoLF0ohldEtMEY="
    ];
    trusted-users = [
      "gep"
    ];
    secret-key-files = [
      config.age.secrets."cache.gepbord.ovh-1.priv".path
    ];
  };

  # expose the current nix store to cache.gepbird.ovh
  services.nginx.virtualHosts."cache.gepbird.ovh" = lib.mkIf enableServing {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.nix-serve.port}";
      recommendedProxySettings = true;
    };
  };

  # a proxy store only locally exposed, it
  # - returns cache.gepbird.ovh if it is online
  # - returns a dummy nix store if it is offline
  services.nginx.virtualHosts."cache.gepbird.ovh-proxy" = {
    listen = [
      {
        addr = "localhost";
        port = proxyStorePort;
      }
    ];
    locations = {
      "/nix-cache-info".extraConfig = ''
        return 200 'StoreDir: /nix/store\nWantMassQuery: 1\nPriority: 30\n';
      '';
      "/" = {
        proxyPass = "https://cache.gepbird.ovh";
        recommendedProxySettings = true;
        extraConfig = ''
          proxy_connect_timeout 500ms;
          error_page 502 504 = @fallback;
        '';
      };
      "@fallback".extraConfig = ''
        try_files _ =404;
      '';
    };
  };
}
