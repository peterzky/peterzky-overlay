{ stdenv, lib, fetchFromGitLab, cmake }:

stdenv.mkDerivation rec {
  pname = "space2meta";
  version = "git";

  src = fetchFromGitLab {
    owner = "interception/linux/plugins";
    repo = "space2meta";
    rev = "76f9f678b609abe29d4f959c2d439b955036c64b";
    sha256 = "18bp8agpb0z05pyj2ffvkd0ls5mdq5phx1xqxrg5jj9r3cpbfik7";
    # date = 2021-05-11T12:21:15-03:00;
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
