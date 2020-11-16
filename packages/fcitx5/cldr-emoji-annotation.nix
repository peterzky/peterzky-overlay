{ stdenv, fetchFromGitHub,  autoconf, automake }:

stdenv.mkDerivation rec {
  name = "cldr-emoji-annotation";
  src = fetchFromGitHub {
    owner = "fujiwarat";
    repo = "cldr-emoji-annotation";
    rev = "f8c894a865251d7fad7c93fe8f8837e79efa02ad";
    # date = 2019-10-25T16:12:30+09:00;
    sha256 = "0ja9zdizd6dpvja4wvyhn67if4nlxrd6r3f2rpa59pwghing1p64";
  };
  nativeBuildInputs = [ autoconf automake ];
  buildPhase = ''
    ./autogen.sh --prefix=$out
    make
  '';

}
