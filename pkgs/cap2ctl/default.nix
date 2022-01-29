{ stdenv, cmake, fetchFromGitHub }:
stdenv.mkDerivation {
  pname = "cap2ctl";
  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "peterzky";
    repo = "cap2ctl";
    rev = "11f43b9788deb71699179f2f0744aa20f544d1b9";
    sha256 = "1kz8xbpf5vr210lcs4ba4i1xs2m4j4x8ngan93ig2qyv917gad5h";
  };

  nativeBuildInputs = [ cmake ];
}
