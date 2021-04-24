{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "ede702a85f60325ca8694595d1d11d9539470e12";
    sha256 = "0mbifyz3zn9y6i4vhgpg582jsmc23qal89m2hlhsh53ifcdw60yl";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make dnscrypt-proxy
  '';
  installPhase = ''
    install -m644 -D dnscrypt-proxy-forwarding-rules.txt $out/share/forwarding-rules.txt
  '';

}
