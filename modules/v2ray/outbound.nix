{ address, id, port, path }: {
  na = {
    mux = {
      enabled = false;
      concurrency = 8;
    };
    tag = "na";
    protocol = "vless";
    settings = {
      vnext = [
        {
          inherit address port;
          users = [
            {
              inherit id;
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
