{ stdenv, fetchurl }:
stdenv.mkDerivation rec {
  name = "ncsdk-fw";
  version = "v2.08.01.02";
  src = fetchurl {
    url =
      "https://downloadmirror.intel.com/28191/eng/NCSDK-2.08.01.02.tar.gz";
    sha256 = "1cv9v63g3252kw1nvdnvs17ig0l4fqrp761ajc8k9x6lz71aa7ww";
  };
  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out
    cp ncsdk-x86_64/fw/*.mvcmd $out/
  '';
}
