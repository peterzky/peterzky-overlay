{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "5637f3d7c3ed6622ca14b55cdea3305a27c41152";
    sha256 = "12jp412hm6ww60qbzbmyjl8sk9wmnyqmyv9lnhhrvpsb6zyrhmkb";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make dnscrypt-proxy
  '';
  installPhase = ''
    install -m644 -D dnscrypt-proxy-forwarding-rules.txt $out/share/forwarding-rules.txt
  '';

}
