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


  transport = import ./transport.nix;

  inherit na direct;
in
{
  inbounds = [ dokodemo ];

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
        ip = [
          "geoip:cn"
          "geoip:private"
          "100.86.248.28"
          "100.112.201.124"
        ];
      }

    ];
  };

  inherit transport;
}
