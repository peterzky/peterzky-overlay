{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "549b7ec8cbdae81422c1f8525dcdb947fec1e420";
    sha256 = "192mrjbk8p8y8syqsklnvxh2zkpmnpw0n2s4ibbrscvjx9lfhflk";
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
