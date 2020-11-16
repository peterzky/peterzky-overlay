{ buildPythonPackage, fetchFromGitHub }:

buildPythonPackage rec {
  pname = "service-factory";
  version = "git";

  src = fetchFromGitHub {
    owner = "proofit404";
    repo = "service-factory";
    rev = "372fc6b59cc22182c5f50beb5b330c8c95183fe7";
    sha256 = "0qnkzda807jnax1yfqyv9404afwi5gvbl2c0dk2sps6cbapll40s";
    # date = 2019-09-25T11:17:45-07:00;
  };

  doCheck = false;

  meta = {
    homepage = "https://github.com/pythonic-emacs/service-factory";
    description = "JSON RPC service factory for Python";
  };

}
