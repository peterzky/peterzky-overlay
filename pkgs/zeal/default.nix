{ lib
, fetchFromGitHub
, cmake
, extra-cmake-modules
, pkg-config
, qtbase
, qtimageformats
, qtwebengine
, qtx11extras
, mkDerivation
, libarchive
, libXdmcp
, libpthreadstubs
, xcbutilkeysyms
, wrapQtAppsHook
}:

mkDerivation rec {
  pname = "zeal";
  version = "0.6.999";

  src = fetchFromGitHub {
    owner = "zealdocs";
    repo = "zeal";
    rev = "dbb8eb29db1476a7b117d96e047867577ff73261";
    sha256 = "05l3g742jahgvz1c760n6xxckhcb8l54zlc6sm7bh8f90fhd8iqw";
    # date = 2021-07-18T20:39:34-04:00;
  };

  # we only need this if we are using a version that hasn't been released. We
  # could also match on the "VERSION x.y.z" bit but then it would have to be
  # updated based on whatever is the latest release, so instead just rewrite the
  # line.
  postPatch = ''
    sed -i CMakeLists.txt \
      -e 's@^project.*@project(Zeal VERSION ${version})@'
  '';

  nativeBuildInputs = [ cmake extra-cmake-modules pkg-config wrapQtAppsHook ];

  buildInputs = [
    qtbase
    qtimageformats
    qtwebengine
    qtx11extras
    libarchive
    libXdmcp
    libpthreadstubs
    xcbutilkeysyms
  ];

  meta = with lib; {
    description = "A simple offline API documentation browser";
    longDescription = ''
      Zeal is a simple offline API documentation browser inspired by Dash (macOS
      app), available for Linux and Windows.
    '';
    homepage = "https://zealdocs.org/";
    license = licenses.gpl3;
    maintainers = with maintainers; [ skeidel peterhoeg ];
    platforms = platforms.linux;
  };
}
