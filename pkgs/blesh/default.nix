{ stdenv, fetchFromGitHub, bash, lib }:
stdenv.mkDerivation {
  name = "blesh";
  src = fetchFromGitHub {
    inherit (lib.importJSON ./version.json) owner repo rev sha256;
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
