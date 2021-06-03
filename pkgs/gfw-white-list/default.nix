{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "48cec72d866d56dad78b23d52392dcfb2c343f4e";
    sha256 = "0vsq13drq6yv846n70vq5i3r2898168x9q55nwwniqd4nacwsk7z";
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
