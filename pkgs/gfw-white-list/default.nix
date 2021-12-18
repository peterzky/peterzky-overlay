{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "8214be576632be58d85ce07b186c47ac7485aa20";
    sha256 = "1d1x8sm6rfk95r4drrww6hb09ga9rvlncw65x7n89bb1j4k0mp3i";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make SERVER=119.29.29.29 unbound
  '';
  installPhase = ''
    install -m644 -D accelerated-domains.china.unbound.conf $out/accelerated-domains.china.unbound.conf
    install -m644 -D apple.china.unbound.conf $out/apple.china.unbound.conf
    install -m644 -D google.china.unbound.conf $out/google.china.unbound.conf
  '';

}
