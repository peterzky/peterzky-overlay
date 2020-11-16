{ lib, mkDerivation, fetchFromGitHub, cmake, extra-cmake-modules, fcitx5
, pkgconfig, qtbase, qtx11extras }:

mkDerivation rec {
  name = "fcitx5-qt";

  src = fetchFromGitHub {
    owner = "fcitx";
    repo = "fcitx5-qt";
    rev = "b6f2ef3c4d3babc38c1262a5df7ac81fb016857d";
    sha256 = "1i4hbnd8sk3rcf938k18jrc5q103m1qzbfhi16cii98znjhz0s7p";
    # date = 2020-06-15T14:43:59-07:00;
  };

  nativeBuildInputs = [ cmake extra-cmake-modules pkgconfig ];

  buildInputs = [ fcitx5 qtbase qtx11extras ];

  cmakeFlags = [
    "-DENABLE_QT4=OFF"
    "-DENABLE_QT5=ON" # "-DBUILD_ONLY_PLUGIN=ON"
  ];

  preConfigure = ''
    substituteInPlace qt5/platforminputcontext/CMakeLists.txt \
      --replace \$"{CMAKE_INSTALL_QTPLUGINDIR}" $out/${qtbase.qtPluginPrefix}
  '';

  meta = with lib; {
    homepage = "https://gitlab.com/fcitx/fcitx-qt5";
    description = "Qt5 IM Module for Fcitx";
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ericsagnes ];
  };
}
