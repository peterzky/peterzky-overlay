{ stdenv, fetchFromGitHub, lib }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchFromGitHub {
    inherit (lib.importJSON ./version.json) owner repo rev sha256;
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
