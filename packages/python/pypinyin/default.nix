{ buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "pypinyin";
  version = "0.30.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1fafd9n581wx42ynim57s7nyiy7v0jkvwrzxqfwfxzrgg30p6x7w";
  };

  doCheck = false;

  meta = {
    homepage = "https://github.com/mozillazg/python-pinyin";
    description = "pinyin convert library";
  };

}
