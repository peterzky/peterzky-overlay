{ buildPythonPackage, fetchFromGitHub, pyqt5 }:

buildPythonPackage rec {
  pname = "pyqt5-stubs";
  version = "5.11.3.org";

  src = fetchFromGitHub {
    owner = "stlehmann";
    repo = "PyQt5-stubs";
    rev = "${version}";
    sha256 = "0abjvf7vnlpkpygy524hfdz6d320iwy3k2rrgds9lzsaa8d0chcy";
    # date = 2019-05-08T13:16:48+02:00;
  };

  propagatedBuildInputs = [ pyqt5 ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/stlehmann/PyQt5-stubs";
    description = "Stubs for PyQt5";
  };

}
