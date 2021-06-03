{ address, id, port, path }:
with import ./outbound.nix { inherit address id port path; };
with builtins;

let
  dokodemo = {
    protocol = "dokodemo-door";
    port = 12345;
    sniffing = {
      enabled = true;
      destOverride = [ "http" "tls" ];
    };
    settings = {
      network = "tcp,udp";
      timeout = 60;
      followRedirect = true;
    };
  };

  dns = {
    protocol = "dokodemo-door";
    port = 5354;
    settings = {
      address = "8.8.8.8";
      port = 53;
      network = "udp";
      timeout = 0;
      followRedirect = false;
    };
  };

  transport = import ./transport.nix;

  inherit na direct;
in
{
  inbounds = [ dokodemo dns ];

  outbounds = [ na direct ];

  dns = { servers = [ "localhost" ]; };

  routing = {
    domainStrategy = "IPOnDemand";

    rules = [

      {
        type = "field";
        outboundTag = "direct";
        protocol = [ "bittorrent" ];
      }

      {
        type = "field";
        outboundTag = "direct";
        domain = [
          "regexp:.\\steam.*\\.com$"
          "domain:jd.com"
          "domain:tsinghua.edu.cn"
          "domain:peterzky.xyz"
          "domain:qq.com"
          "geosite:cn"
        ];
      }

      {
        type = "field";
        outboundTag = "direct";
        ip = [ "geoip:cn" "geoip:private" ];
      }

    ];
  };

  inherit transport;
}
