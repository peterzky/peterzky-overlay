{ stdenv, fetchFromGitLab, cmake }:

stdenv.mkDerivation rec {
  pname = "space2meta";
  version = "git";

  src = fetchFromGitLab {
    owner = "interception/linux/plugins";
    repo = pname;
    rev = "5f3d6a3da3ddd6164835e2f9b33664e547a85a74";
    sha256 = "125w71jpa3slbq2ki4j8zydj4qdrvqb1f3nwaf9x27byj8xj65cd";
  };

  nativeBuildInputs = [ cmake ];

  meta = with stdenv.lib; {
    homepage = "https://gitlab.com/interception/linux/plugins/space2meta";
    description = "Turn your space key into the meta key when chorded to another key.";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
