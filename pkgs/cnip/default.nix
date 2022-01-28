{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation {
  pname = "cnip";
  version = "git";
  src = fetchFromGitHub {
    inherit (lib.importJSON ./version.json) owner repo rev sha256;
  };

  dontBuild = true;

  installPhase = ''
    cp cnip.txt $out
  '';
}
