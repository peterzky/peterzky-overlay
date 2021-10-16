{ stdenv, fetchFromGitHub, bash, lib }:
stdenv.mkDerivation {
  name = "blesh";
  src = fetchFromGitHub {
    owner = "akinomyoga";
    repo = "ble.sh";
    rev = "26aaf8759c1aa3e47f405e820dc07684c9ec71e1";
    # date = 2021-10-05T07:45:56+09:00;
    sha256 = "0bwvvr7fk7fqmg4k5r6n122ld3qahi2nvz69vyxb5r5mqq7aby4i";
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
