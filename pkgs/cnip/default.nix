{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation {
  pname = "cnip";
  version = "git";
  src = fetchFromGitHub {
    inherit (lib.importJSON ./version.json) owner repo rev sha256;
  };

  # dontBuild = true;
  buildPhase = ''
    echo "create cn hash:net family inet hashsize 2048 maxelem 65536" > cn.ipset
    while read ip; do
      echo add cn $ip >> cn.ipset
    done < cnip.txt
  '';

  installPhase = ''
    # cp cnip.txt $out
    cp cn.ipset $out
  '';
}
