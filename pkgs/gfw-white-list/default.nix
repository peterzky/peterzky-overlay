{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "77d061180aa6f7b2acdf7d831a8d3da9bc056b29";
    sha256 = "1fjphv8vdh2jwy116c5vn8lr34k749dvgirpk166az97fs86h3nf";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make SERVER=119.29.29.29 dnsmasq
  '';
  installPhase = ''
    install -m644 -D accelerated-domains.china.dnsmasq.conf $out/accelerated-domains.china.dnsmasq.conf
    install -m644 -D apple.china.dnsmasq.conf $out/apple.china.dnsmasq.conf
    install -m644 -D google.china.dnsmasq.conf $out/google.china.dnsmasq.conf
  '';

}
