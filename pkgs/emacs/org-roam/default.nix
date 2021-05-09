{ stdenv, emacsPackages, emacs }:
stdenv.mkDerivation rec {
  name = "org-roam-${version}";
  version = "2.0.0a1";
  src = fetchFromGitHub {
    owner = "org-roam";
    repo = "org-roam";
    rev = "2.0.0a1";
    sha256 = "05aqqvq3vxfj1g6kbqli0dpmrlplmzq14lazcfw5sq1km48irh60";
  };

  buildInputs = with emacsPackages; [];
  nativeBuildInputs = [ emacs ];
  buildPhase = ''
    export sharedir=$out;
    make
  '';
}
