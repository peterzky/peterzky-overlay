# updating v2ray
# run update script
# run vgo2nix on new commit in $home/golang/src/v2ray.com/v2ray-core
# substitute 'go.googlesource.com' with 'github.com/golang' in deps.nix
{ buildGoPackage, fetchurl, fetchFromGitHub }:
let
  geoipRev = "202011050012";
  geoipSha256 = "1d2n3hskgdmcfk1nl7a8lxxz325p84i7gz44cs77z1m9r7c2vsjy";
  geoip = fetchurl {
    url =
      "https://github.com/v2ray/geoip/releases/download/${geoipRev}/geoip.dat";
    sha256 = geoipSha256;
  };
  geositeRev = "20201102141726";
  geositeSha256 = "0sn2f5vd6w94ryh845mnbfyjzycg7cvb66rkzh37pg9l7fvgs4jh";
  domain = fetchurl {
    url =
      "https://github.com/v2ray/domain-list-community/releases/download/${geositeRev}/dlc.dat";
    sha256 = geositeSha256;
  };

in buildGoPackage rec {
  name = "v2ray";
  version = "4.31.0";

  src = fetchFromGitHub {
    owner = "v2ray";
    repo = "v2ray-core";
    rev = "v${version}";
    sha256 = "0s0blc05nrqm78qslv5xb42pjlx5v8qqwg0pwbzhxn9s71x2669m";
  };

  postConfigure = ''
    v2ctl=go/src/v2ray.com/core/infra/control
    mv $v2ctl/main $v2ctl/v2ctl
  '';

  subPackages = [ "main" "infra/control/v2ctl" ];

  goPackagePath = "v2ray.com/core";

  goDeps = ./deps.nix;

  postInstall = ''
    mkdir -p $out/bin/ext
    mv $out/bin/main $out/bin/v2ray
    install -Dm755 ${domain} $out/ext/geosite.dat
    install -Dm755 ${geoip} $out/ext/geoip.dat
  '';

}
