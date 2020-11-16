self: super: {
  chnroute-ipset =
    super.writeText "chnrout.ipset" (builtins.readFile ../files/chnroute.ipset);
  dnscrypt-proxy-conf = super.writeText "dnscrypt-proxy.toml"
    (builtins.readFile ../files/dnscrypt-proxy.toml);
}
