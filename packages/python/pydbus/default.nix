{ buildPythonPackage, fetchFromGitHub, pygobject3 }:

buildPythonPackage rec {
  pname = "pydbus";
  version = "git";

  src = fetchFromGitHub {
    owner = "LEW21";
    repo = "pydbus";
    rev = "cc407c8b1d25b7e28a6d661a29f9e661b1c9b964";
    sha256 = "1y4bqgrwdvnpjgv7zvp1ms97i0b1bp4ly2mv55w6l84pn6nv790m";
    # date = 2018-05-06T14:24:33+02:00;
  };

  propagatedBuildInputs = [ pygobject3 ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/LEW21/pydbus";
    description = "Pythonic DBus Library";
  };

}
