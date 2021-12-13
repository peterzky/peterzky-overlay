{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "f4595d51d556a6363d06d9664e1dd2934bb0f389";
    sha256 = "1sip67rvp4xsvpic2g6ilkh8c7ckvvn25ca50xhs6cql3969vy2i";
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
