# updating v2ray
# run update script
# run vgo2nix on new commit in $home/golang/src/v2ray.com/v2ray-core
# substitute 'go.googlesource.com' with 'github.com/golang' in deps.nix
{ buildGoPackage, fetchurl, fetchFromGitHub }:
let
  geoipRev = "202109160028";
  geoipSha256 = "1jjh5z5z036z42m24d0rllaz0ha3257lyknjp71ba7pmj228l32k";
  geoip = fetchurl {
    url =
      "https://github.com/v2ray/geoip/releases/download/${geoipRev}/geoip.dat";
    sha256 = geoipSha256;
  };
  geositeRev = "20210910080130";
  geositeSha256 = "0d6bzrs5mhca59j1w73kqw10jqkwic9ywm3jvszpd077qwh64dwn";
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
    mv $out/bin/main $out/bin/v2ray
    install -Dm755 ${domain} $out/ext/geosite.dat
    install -Dm755 ${geoip} $out/ext/geoip.dat
  '';

}
