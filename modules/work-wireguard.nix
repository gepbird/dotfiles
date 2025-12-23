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
in
{
  networking.wireguard = {
    enable = true;
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
  sops.templates = {
    wireguard-wg0-start.content = # sh
      ''
        modprobe wireguard || true

        ip link add dev wg0 type wireguard
        ip address add ${placeholder "interface-ip"} dev wg0
        wg set wg0 private-key ${secrets.private-key}
        ip link set up dev wg0
      '';
    wireguard-wg0-peer-work-start.content = # sh
      ''
        wg set wg0 peer ${placeholder "public-key"} preshared-key ${secrets.preshared-key} endpoint ${placeholder "endpoint"} allowed-ips ${placeholder "peer-ips-1"},${placeholder "peer-ips-2"}
        ip route replace ${placeholder "peer-ips-1"} dev wg0 table main
        ip route replace ${placeholder "peer-ips-2"} dev wg0 table main
      '';
    wireguard-wg0-peer-work-post-stop.content = # sh
      ''
        wg set wg0 peer ${placeholder "public-key"} remove
        ip route delete ${placeholder "peer-ips-1"} dev wg0 table main
        ip route delete ${placeholder "peer-ips-2"} dev wg0 table main
      '';
  };

  systemd.services = {
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
      };
    };
  };
}
