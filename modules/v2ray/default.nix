{ config, lib, pkgs, ... }:

with lib;

let
  v2ray = pkgs.v2ray;

  cfg = config.services.my-v2ray;

  genJSON = generators.toJSON {};

in
{
  options = {
    services.my-v2ray = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable v2ray server.
        '';
      };

      address = mkOption {
        type = types.str;
        default = "";
        description = ''
          server address
        '';
      };


      port = mkOption {
        type = types.int;
        default = "";
        description = ''
          server address
        '';
      };

      id = mkOption {
        type = types.str;
        default = "";
        description = ''
          server id
        '';
      };

      path = mkOption {
        type = types.str;
        default = "/";
        description = ''
          server path
        '';
      };

    };
  };

  config =
    let
      conf = pkgs.writeText "v2ray-client.json" (
        genJSON (
          import ./client.nix {
            inherit (cfg) address id port path;
          }
        )
      );
    in
      mkIf cfg.enable {
        systemd.services."v2ray-client" = {
          description = "v2ray local service";
          environment = { V2RAY_LOCATION_ASSET = "${v2ray}/ext"; };
          path = [ pkgs.iptables pkgs.ipset ];
          preStart = ''
            # load ipset
            ipset -! -f ${pkgs.chnroute-ipset} restore
            iptables -w -t nat -N V2RAY || true

            # dns server direct
            # iptables -w -t nat -A V2RAY -m owner --uid-owner dns -j RETURN || true
            iptables -w -t nat -A V2RAY -d 1.1.1.1 -j RETURN || true


            # server direct
            iptables -w -t nat -A V2RAY -d 192.168.0.103 -j RETURN || true
            iptables -w -t nat -A V2RAY -d 0.0.0.0/8 -j RETURN || true
            iptables -w -t nat -A V2RAY -d 10.0.0.0/8 -j RETURN || true
            iptables -w -t nat -A V2RAY -d 127.0.0.0/8 -j RETURN || true
            iptables -w -t nat -A V2RAY -d 169.254.0.0/16 -j RETURN || true
            iptables -w -t nat -A V2RAY -d 172.16.0.0/12 -j RETURN || true
            iptables -w -t nat -A V2RAY -d 192.168.0.0/16 -j RETURN || true
            iptables -w -t nat -A V2RAY -d 224.0.0.0/4 -j RETURN || true
            iptables -w -t nat -A V2RAY -d 240.0.0.0/4 -j RETURN || true
            iptables -w -t nat -A V2RAY -p tcp -m mark --mark 0xff -j RETURN || true

            # ipset chnroute
            iptables -w -t nat -A V2RAY -m set --match-set chnroute dst -j RETURN || true
            iptables -w -t nat -A V2RAY -p tcp -j REDIRECT --to-ports 12345 || true

            # enable transparent proxy
            iptables -w -t nat -A OUTPUT -p tcp -j V2RAY || true
          '';

          preStop = ''
            iptables -w -t nat -D OUTPUT -p tcp -j V2RAY
            iptables -w -t nat -F V2RAY
            iptables -w -t nat -X V2RAY
            ipset flush
            ipset destroy chnroute
          '';

          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${v2ray}/bin/v2ray -config ${conf}";
            Restart = "always";
            RestartSec = 5;
          };
        };
      };
}
