{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "540a3e59bc9201f8fb9296a21552ab429dc56e39";
    sha256 = "06mzz4q15bms9w57sxh16c162d25k31i4alrmsk381gdy5z8rcab";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make dnscrypt-proxy
  '';
  installPhase = ''
    install -m644 -D dnscrypt-proxy-forwarding-rules.txt $out/share/forwarding-rules.txt
  '';

}
