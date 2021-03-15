self: super: {
  chnroute-ipset =
    super.writeText "chnrout.ipset" (builtins.readFile ../files/chnroute.ipset);
}
