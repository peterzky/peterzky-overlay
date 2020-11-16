{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "https://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "348b6445817b51107382321f5ccaea2f9f32dba6";
    sha256 = "1mrlhhj0kqkbhh9pryh322svmngs5cyf570bzj6q81bazmjg9816";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make dnscrypt-proxy
  '';
  installPhase = ''
    install -m644 -D dnscrypt-proxy-forwarding-rules.txt $out/share/forwarding-rules.txt
  '';

}
