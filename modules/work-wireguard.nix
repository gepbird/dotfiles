self:
{
  config,
  lib,
  pkgs,
  ...
}:

let
  secrets = config.secrets.gep.work.wireguard;
  placeholder = secretName: config.sops.placeholder."gep/work/wireguard/${secretName}";

  # systemd services don't have execute permission in /run
  # where sops-nix puts the rendered templates
  bootstrapScript =
    name:
    lib.mkForce (
      pkgs.writeShellScript "${name}-bootstrap" "${lib.getExe pkgs.bash} ${
        config.sops.templates.${name}.path
      }"
    );

  # this will be later overwritten with sops templates
  stub = "stub";

  peer-ips = lib.filterAttrs (n: v: lib.hasPrefix "peer-ips-" n) secrets;
in
{
  networking.wireguard = {
    enable = config.enableSecrets;
    interfaces = {
      wg0 = {
        ips = [ stub ];
        privateKeyFile = stub;
        peers = [
          {
            name = "work";
            publicKey = stub;
            presharedKeyFile = stub;
            allowedIPs = [
              stub
              stub
            ];
            endpoint = stub;
          }
        ];
      };
    };
  };

  # implementation details are taken from:
  # https://github.com/NixOS/nixpkgs/blob/1306659b587dc277866c7b69eb97e5f07864d8c4/nixos/modules/services/networking/wireguard.nix
  sops.templates = lib.optionalAttrs config.enableSecrets {
    wireguard-wg0-start.content = # sh
      ''
        set -euo pipefail

        modprobe wireguard || true

        ip link add dev wg0 type wireguard
        ip address add ${placeholder "interface-ip"} dev wg0
        wg set wg0 private-key ${secrets.private-key}
        ip link set up dev wg0
      '';
    wireguard-wg0-peer-work-start.content = # sh
      ''
        set -euo pipefail

        wg set wg0 peer ${placeholder "public-key"} preshared-key ${secrets.preshared-key} endpoint ${placeholder "endpoint"} allowed-ips ${
          lib.concatMapAttrsStringSep "," (n: v: placeholder n) peer-ips
        }

        ${lib.concatMapAttrsStringSep "\n" (n: v: "ip route replace ${placeholder n} dev wg0 table main") peer-ips}
      '';
    wireguard-wg0-peer-work-post-stop.content = # sh
      ''
        set -euo pipefail

        wg set wg0 peer ${placeholder "public-key"} remove

        ${lib.concatMapAttrsStringSep "\n" (n: v: "ip route delete ${placeholder n} dev wg0 table main") peer-ips}
      '';
  };

  systemd.services = lib.optionalAttrs config.enableSecrets {
    wireguard-wg0 = {
      serviceConfig = {
        ExecStart = bootstrapScript "wireguard-wg0-start";
      };
    };
    wireguard-wg0-peer-work = {
      description = lib.mkForce "WireGuard Peer - wg0 - work";
      serviceConfig = {
        ExecStart = bootstrapScript "wireguard-wg0-peer-work-start";
        ExecStopPost = bootstrapScript "wireguard-wg0-peer-work-post-stop";
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
  };
}
