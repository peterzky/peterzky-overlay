{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "gfw-white-list";
  src = fetchgit {
    url = "http://github.com/felixonmars/dnsmasq-china-list.git";
    rev = "cc4ead9dde27d9f8baae63688ed5ad66fa6c3472";
    sha256 = "0axr55911yzxx8s27hri4xwgbgvb2hpj5nqyf208w98wp47zk7lj";
    # date = 2020-11-02T10:17:12+00:00;
  };
  buildPhase = ''
    make dnscrypt-proxy
  '';
  installPhase = ''
    install -m644 -D dnscrypt-proxy-forwarding-rules.txt $out/share/forwarding-rules.txt
  '';

}
