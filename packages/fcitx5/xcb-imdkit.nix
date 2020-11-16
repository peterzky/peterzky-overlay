{ stdenv, extra-cmake-modules, fetchFromGitHub, pkgconfig, xorg }:

stdenv.mkDerivation rec {
  name = "xcb-imdkit";
  src = fetchFromGitHub {
    owner = "fcitx";
    repo = "xcb-imdkit";
    rev = "db6cfd4f2d75145134ef635725eebb1799415430";
    # date = 2020-03-17T17:38:50-07:00;
    sha256 = "17m4hqa3z6q8bxwin19wsylf5x06x9jzl3s3rhywg3p429gmb812";
  };

  nativeBuildInputs = [ extra-cmake-modules pkgconfig ];

  buildInputs = with xorg; [ xcbutil xcbutilkeysyms ];
}
