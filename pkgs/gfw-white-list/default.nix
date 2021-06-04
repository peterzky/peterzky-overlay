{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "71f82588d85e585b92a6556bcf9797a7af9577a2";
    sha256 = "10nxyns543cjs4yfqhkvv2c2aypyjms678dcgshv5bdsgb3n1p8q";
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
