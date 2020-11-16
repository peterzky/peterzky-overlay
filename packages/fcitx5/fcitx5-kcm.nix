{ mkDerivation, fetchFromGitHub, extra-cmake-modules, gettext, pkgconfig, fcitx5
, fcitx5-qt, isocodes, xorg, kdeFrameworks, qtbase, qtx11extras }:

mkDerivation rec {
  name = "kcm-fcitx5";
  src = fetchFromGitHub {
    owner = "fcitx";
    repo = "kcm-fcitx5";
    rev = "21dbb519360c2447461085bd8c5234e0e8bdd81a";
    # date = 2020-06-15T00:01:37-07:00;
    sha256 = "12klk55v2m60x74ijf54p0ja2gc8x9zc9yvabyvlricwp3626cyv";
  };

  cmakeFlags = [ "-DENABLE_KCM=OFF" ];

  nativeBuildInputs = [ extra-cmake-modules pkgconfig ];

  buildInputs = [ qtx11extras qtbase ]
    ++ (with kdeFrameworks; [ kitemviews kwidgetsaddons ])
    ++ (with xorg; [ xkeyboardconfig libxkbfile ])
    ++ [ gettext fcitx5 fcitx5-qt isocodes ];

  prePatch = ''
    substituteInPlace CMakeLists.txt \
      --replace "QT_MIN_VERSION \"5.14.0\"" "QT_MIN_VERSION \"5.12.0\""
  '';

}
