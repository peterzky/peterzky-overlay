{stdenv, fetchFromGitHub, libime, fcitx5-qt5, opencc, extra-cmake-modules, pkgconfig }:
stdenv.mkDerivation rec {
  name = "fcitx5-chinese-addons";
  src = fetchFromGitHub {
    owner = "fcitx";
    repo = "fcitx5-chinese-addons";
    rev = "dfa59e5340e20b9754197ccf90b404c1a5ac72d1";
    # date = 2020-06-25T18:00:42-07:00;
    sha256 = "1j2g0j4kl9ggg1y393jy800cbwz5grlm6mfzd43v8nki8rjv1jz4";
  };

  nativeBuildInputs = [extra-cmake-modules pkgconfig];

  buildInputs = [libime fcitx5-qt5 opencc ];

}
