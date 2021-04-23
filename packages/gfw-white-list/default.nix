{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "60b81c73951d610719b3a48f2c8d918191363e39";
    sha256 = "0zd97z2gafyprmdxqp2yxsr8lk6n6sh54djibvcka8xgfzw7zza2";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make dnscrypt-proxy
  '';
  installPhase = ''
    install -m644 -D dnscrypt-proxy-forwarding-rules.txt $out/share/forwarding-rules.txt
  '';

}
