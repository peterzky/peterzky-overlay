{ lib, python3, stdenv, fetchgit }:
stdenv.mkDerivation {
  pname = "nvd";
  version = "0.0.1";

  src = fetchgit {
    url = "https://gitlab.com/khumba/nvd.git";
    rev = "fd059e5b2ef64c27f4062d5438225ac0ebb8e193";
    # date = 2021-07-20T03:57:51+00:00;
    sha256 = "0hr739yszm0lcp76c5jhmas2ix5j1an51baf69nixb2m3dcdp1i7";
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
