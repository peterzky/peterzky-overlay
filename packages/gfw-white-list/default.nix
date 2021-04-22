{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "ea3d0dcfffa3bc326b2bb1002cbcb40a93ed38e3";
    sha256 = "1kynw6wn1vmkjn9lfa0x2f81sxdrjdq54qmgaqjrv52ciydz05vk";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make dnscrypt-proxy
  '';
  installPhase = ''
    install -m644 -D dnscrypt-proxy-forwarding-rules.txt $out/share/forwarding-rules.txt
  '';

}
