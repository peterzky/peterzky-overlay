{ stdenv, fetchFromGitHub, libX11, libXinerama, libXft, xorg, patches ? [ ] }:

let name = "dwm-6.2";
in stdenv.mkDerivation {
  inherit name;

  # src = fetchFromGitHub {
  #   owner = "peterzky";
  #   repo = "dwm";
  #   sha256 = "0hv7qr7c3bzb8xcdr1azn07q2lv14vxq42x6y85x3sw8kw8daw9p";
  #   rev = "2b72a892f29367661815581fc8d456c14c2c42c3";
  # };

  src = /home/peterzky/projects/dwm;

  buildInputs = [ libX11 libXinerama libXft ] ++ [ xorg.libxcb ];

  prePatch = ''sed -i "s@/usr/local@$out@" config.mk'';

  # Allow users set their own list of patches
  inherit patches;

  buildPhase = " make ";

  meta = {
    homepage = "https://suckless.org/";
    description = "Dynamic window manager for X";
    license = stdenv.lib.licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ viric ];
    platforms = with stdenv.lib.platforms; all;
  };
}
