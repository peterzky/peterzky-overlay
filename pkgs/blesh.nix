{ stdenv, fetchFromGitHub, bash, lib }:
stdenv.mkDerivation {
  name = "blesh";
  src = fetchFromGitHub {
    owner = "akinomyoga";
    repo = "ble.sh";
    rev = "2243e9117d2e7adad11b69d5ca04f2b2376c70b6";
    # date = 2021-10-30T18:26:47+09:00;
    sha256 = "16ys9s6syyifyxqhma656hr2xjd1rrp6h2rjfg93jhp521zanj1d";
    fetchSubmodules = true;
  };

  patchPhase = ''
    sed -i '/git submodule update/d' GNUmakefile
  '';
  buildPhase = ''
    make
  '';
  installPhase = ''
    sed -i 's|/usr/bin readlink|/run/current-system/sw/bin readlink|' out/ble.sh
    mkdir $out
    cp -r out/* $out/
  '';
}
