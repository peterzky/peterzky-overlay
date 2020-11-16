{ stdenv, fetchhg, meson, ninja, wayland, gtk3, pkgconfig, wrapGAppsHook }:

stdenv.mkDerivation rec {
  pname = "wofi";
  version = "head";

  src = fetchhg {
    url = "https://hg.sr.ht/~scoopta/wofi";
    rev = "e3db9b8075e7";
    sha256 = "07fr1yfls94gxpwv3azgzxm7shjs4g5ribvqrh88flpf4cv5hq2d";
  };

  nativeBuildInputs = [ meson ninja pkgconfig wrapGAppsHook ];

  buildInputs = [ wayland gtk3 ];

}
