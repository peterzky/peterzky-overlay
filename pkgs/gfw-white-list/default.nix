{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "8bb99f1abf2e59bd549c1d90365b4aa29026b032";
    sha256 = "049cid9f9mrz8s01ya283apjpl4zdqv039x4zjg2rzw0ffdzknmz";
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
