{ stdenv, wofi }:
stdenv.mkDerivation {
  name = "sws";
  src = ./.;
  dontBuild = true;
  propagatedBuildInputs = [ wofi ];
  installPhase = ''
    substituteInPlace sws --replace "wofi" "${wofi}/bin/wofi"
    mkdir -p $out/bin
    cp sws $out/bin
    chmod +x $out/bin/sws
  '';
}
