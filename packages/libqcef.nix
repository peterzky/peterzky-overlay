{ stdenv, gnome2, nss, libpulseaudio, cmake, fetchgit, qt5, pkgconfig
, autoPatchelfHook, xlibs, alsaLib, cups, gtk2-x11, atk, cairo, gdk_pixbuf }:

stdenv.mkDerivation {
  name = "qcef";
  src = fetchgit {
    url = "https://github.com/linuxdeepin/qcef.git";
    sha256 = "1xi97akj6133mqizlwf7wyq4may8vwyj3gvxrvhc23xwji7mj9rh";
    rev = "d25f0421d64749d7cd2e3b3557585748787c32c3";
    fetchSubmodules = true;
    # date = 2019-01-02T15:12:30+08:00;
  };

  postPatch = ''
    sed -i '/add_executable(web-demo/,/^$/s/^/#/' src/CMakeLists.txt
  '';

  nativeBuildInputs = [ cmake pkgconfig autoPatchelfHook ];
  buildInputs = with qt5;
    [
      gnome2.GConf
      nss
      libpulseaudio
      xlibs.libXtst
      xlibs.libXrandr
      xlibs.libXScrnSaver
      xlibs.libXcursor
      xlibs.libXdamage
      alsaLib
      cups.lib
      gtk2-x11
      gnome2.pango
      atk
      cairo
      gdk_pixbuf
    ] ++ [ qtbase qtwebchannel qtx11extras qttools ];

}
