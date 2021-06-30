{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "26365fba31bc539065b8b895d30552dd5bbd2b52";
    sha256 = "033xcqvdib48940f0rywrxrrgj1fyfdhn0xf3mqbfly1szi540x6";
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
