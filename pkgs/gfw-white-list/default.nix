{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "17fea1962a97d4980a65ea15a3d02a0ac1dbee7a";
    sha256 = "02js7gbx5izrms8zm2kf17wgfilzyvxwx2qsn55bs0fbk8ik7yb8";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make dnsmasq
  '';
  installPhase = ''
    install -m644 -D accelerated-domains.china.dnsmasq.conf $out/accelerated-domains.china.dnsmasq.conf
    install -m644 -D apple.china.dnsmasq.conf $out/apple.china.dnsmasq.conf
    install -m644 -D google.china.dnsmasq.conf $out/google.china.dnsmasq.conf
  '';

}
