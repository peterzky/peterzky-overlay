{ fetchgit, python3Packages, }:

with python3Packages;

buildPythonPackage rec {
  pname = "webmacs";
  version = "0.8";

  patchPhase = ''
    sed -i '/if "CC" not in/d' setup.py
    sed -i 's/    \(os\.environ.*$\)/\1/' setup.py
  '';

  src = fetchgit {
    url = "https://github.com/parkouss/webmacs.git";
    rev = "20f894233c84b78e82f128e77fefb794c22a1db2";
    sha256 = "00shwg6b5825438kpkbs2hn2fbcn5psj07p4b3axbrm2vhwrj7ks";
    fetchSubmodules = true;
  };

  doCheck = false;

  propagatedBuildInputs = [ pyqt5 python-dateutil dateparser pygments jinja2 ];

  meta = {
    homepage = "https://github.com/parkouss/webmacs";
    description = "keyboard driven emacs key bindings browser";
  };
}
