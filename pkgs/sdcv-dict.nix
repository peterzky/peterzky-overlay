{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "sdcv-dict";
  src = fetchFromGitHub {
    owner = "peterzky";
    repo = "startdict_dictionary";
    rev = "0243363d9757bff738faef35627b998dc6cebe97";
    # date = 2021-05-03T22:26:53+08:00;
    sha256 = "0d1kgs52npq2ww4dms8af3qz79fsdk68qihv1b83bhhzfd12x4xm";
  };
  dontBuild = true;
  installPhase = ''
    mkdir -p $out
    for dict in *.tar.bz2; do
      tar xjf $dict -C $out
    done
  '';

}
