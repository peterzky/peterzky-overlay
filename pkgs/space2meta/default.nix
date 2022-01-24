{ stdenv, lib, fetchFromGitLab, cmake }:

stdenv.mkDerivation rec {
  pname = "space2meta";
  version = "git";

  src = fetchFromGitLab {
    inherit (lib.importJSON ./version.json) owner repo rev sha256;
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    homepage = "https://gitlab.com/interception/linux/plugins/space2meta";
    description =
      "Turn your space key into the meta key when chorded to another key.";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
