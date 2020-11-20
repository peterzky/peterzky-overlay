{ stdenv, fetchgit
, fcft, freetype, pixman, libxkbcommon, fontconfig, wayland
, meson, ninja, ncurses, scdoc, tllist, wayland-protocols, pkg-config
}:

stdenv.mkDerivation rec {
  pname = "foot";
  version = "git";

  src = fetchgit {
    url = "https://codeberg.org/dnkl/foot.git";
    rev = "3640164917f227f367a38fe486120fa50627f9b1";
    sha256 = "02bx5pfxsj7cpa2m4n1n6fphjkzzzdyyhkq63widazqb62fiviy1";
    # date = 2020-11-19T19:26:06+01:00;
  };

  nativeBuildInputs = [
    meson ninja ncurses scdoc tllist wayland-protocols pkg-config
  ];
  buildInputs = [
    fontconfig freetype pixman wayland libxkbcommon fcft
  ];

  # recommended build flags for foot as per INSTALL.md
  # https://codeberg.org/dnkl/foot/src/branch/master/INSTALL.md#user-content-release-build
  preConfigure = ''
    export CFLAGS+="-O3 -fno-plt"
  '';

  mesonFlags = [ "--buildtype=release" "-Db_lto=true" ];

  meta = with stdenv.lib; {
    homepage = "https://codeberg.org/dnkl/foot/";
    description = "A fast, lightweight and minimalistic Wayland terminal emulator";
    license = licenses.mit;
    maintainers = [ maintainers.sternenseemann ];
    platforms = platforms.linux;
  };
}
