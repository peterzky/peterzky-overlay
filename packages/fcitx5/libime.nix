{ stdenv, fetchFromGitHub, extra-cmake-modules, fcitx5, boost, python3 }:
stdenv.mkDerivation rec {
  name = "libime";
  src = fetchFromGitHub {
    owner = "fcitx";
    repo = "libime";
    rev = "2c856684d6d7be0fe0e6cc514a09b2a68c8d1e68";
    sha256 = "0xrknl10pa9rsq2a9lp5xj94vqhw4w6r7cpmbkzn28sz5zqrg81b";
    fetchSubmodules = true;
    # date = 2020-06-25T17:59:08-07:00;
  };
  nativeBuildInputs = [ extra-cmake-modules python3 ];
  buildInputs = [ fcitx5 boost ];
}
