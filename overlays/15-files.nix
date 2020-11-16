self: super: {
  chnroute =
    super.writeText "chnrout.ipset" builtins.readFile ../files/chnroute.ipset;
  dnscrypt-proxy = super.writeText "dnscrypt-proxy.toml" builtins.readFile
    ../files/dnscrypt-proxy.toml;
}
