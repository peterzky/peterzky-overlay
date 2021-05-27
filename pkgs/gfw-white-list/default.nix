{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "a5ecf2ef022d1b383f3fe318304d31e19b1188b1";
    sha256 = "145yrl33hl0m9p93i9wzzhx418lig333lihz9rhvq4d4kk3jqkn8";
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
