{ stdenv, fetchFromGitHub, pkgconfig, fcitx5, librime, brise, gettext
, extra-cmake-modules }:

stdenv.mkDerivation rec {
  name = "fcitx5-rime";

  src = fetchFromGitHub {
    owner = "fcitx";
    repo = "fcitx5-rime";
    rev = "e4fc60043e8c608d344b7f7b3e83116a81d89318";
    # date = 2020-06-15T00:01:42-07:00;
    sha256 = "11wsmi78v1sxr8qj2qlrjsy48b1xa6zghy2k4pyx4gfpa62s00c0";
  };

  buildInputs = [ extra-cmake-modules pkgconfig fcitx5 librime brise gettext ];

  # cmake cannont automatically find our nonstandard brise install location
  cmakeFlags = [ "-DRIME_DATA_DIR=${brise}/share/rime-data" ];

  enableParallelBuilding = true;

  preInstall = ''
    substituteInPlace src/cmake_install.cmake \
       --replace ${fcitx5} $out
    substituteInPlace data/cmake_install.cmake \
       --replace ${fcitx5} $out
  '';

  meta = with stdenv.lib; {
    isFcitxEngine = true;
    homepage = "https://github.com/fcitx/fcitx-rime";
    downloadPage = "https://download.fcitx-im.org/fcitx-rime/";
    description = "Rime support for Fcitx";
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
