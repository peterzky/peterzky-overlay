{ stdenv, fetchgit, lib }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "https://github.com/felixonmars/dnsmasq-china-list.git";
    inherit (lib.importJSON ./version.json) rev sha256;
  };
  buildPhase = ''
    make smartdns SERVER=china
  '';
  installPhase = ''
    install -m644 -D accelerated-domains.china.smartdns.conf $out/accelerated-domains.china.smartdns.conf
    install -m644 -D apple.china.smartdns.conf $out/apple.china.smartdns.conf
    install -m644 -D google.china.smartdns.conf $out/google.china.smartdns.conf
  '';

}
