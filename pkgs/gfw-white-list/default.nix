{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "07f4776ca92ed46afd52116c00b947b9e1274d5d";
    sha256 = "1gcbrqdamrsl59nllvnfv8piwl1v5n5dpsw4125mmfpkvk89fpr7";
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
