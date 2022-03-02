{ buildPythonPackage, fetchPypi }:
buildPythonPackage rec {
  pname = "qasync";
  version = "0.23.0";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-iWXsMT4BBxSNmOisHnenfc503jzZcFWhqmLVE6N5OhQ=";
  };
  doCheck = false;
}
