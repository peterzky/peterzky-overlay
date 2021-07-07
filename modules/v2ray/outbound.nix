{ address, id, port, path }: {
  na = {
    mux = {
      enabled = true;
      concurrency = 8;
    };
    tag = "na";
    protocol = "vmess";
    settings = {
      vnext = [
        {
          inherit address port;
          users = [
            {
              inherit id;
              alterId = 2;
              encryption = "none";
              level = 0;

            }
          ];
        }
      ];

    };
    streamSettings = {
      network = "ws";
      security = "tls";
      tlsSettings = {
        allowInsecure = true;
        serverName = address;
      };
      sockopt = {
        mark = 255;
        tcpFastOpen = true;
      };
      wsSettings = {
        inherit path;
        headers = {
          Host = address;
        };
      };
    };
  };

  direct = {
    protocol = "freedom";
    settings = {};
    tag = "direct";
    streamSettings = { sockopt = { mark = 255; }; };
  };
}
