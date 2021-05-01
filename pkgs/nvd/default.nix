{ lib, python3, stdenv, fetchgit }:
stdenv.mkDerivation {
  pname = "nvd";
  version = "0.0.1";

  src = fetchgit {
    url = "https://gitlab.com/khumba/nvd.git";
    rev = "7cdaa6d818119bd7a51930d990fded5d594c6623";
    # date = 2021-04-10T18:44:27-07:00;
    sha256 = "0z8m48hq27mx2gm9s7p5ii79wp5asabgc67q8s90y6jirfh1y1vm";
  };

  buildInputs = [ python3 ];

  buildPhase = ''
    runHook preBuild
    gzip src/nvd.1
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -m555 -Dt $out/bin src/nvd
    install -m444 -Dt $out/share/man/man1 src/nvd.1.gz
    runHook postInstall
  '';

  meta = {
    description = "Nix/NixOS package version diff tool";
    homepage = "https://gitlab.com/khumba/nvd";
    license = lib.licenses.asl20;
    maintainers = [ lib.maintainers.khumba ];
    platforms = lib.platforms.all;
  };

}
