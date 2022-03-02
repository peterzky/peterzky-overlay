{ buildPythonPackage, fetchPypi }:
buildPythonPackage rec {
  pname = "mutagen";
  version = "1.45.1";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Y5dgLvs8LXuuvSFm7YVzGuHB1HWryiIJC3FB/1A0s+E=";
  };
  doCheck = false;
}
