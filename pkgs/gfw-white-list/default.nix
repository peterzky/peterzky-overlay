{ stdenv, fetchgit, lib }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "https://github.com/felixonmars/dnsmasq-china-list.git";
    inherit (lib.importJSON ./version.json) rev sha256;
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
