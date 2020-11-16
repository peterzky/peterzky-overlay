{ stdenv, fetchgit, python3Packages, xorg }:

with python3Packages;
let
  xlib_23 = python3Packages.xlib.overrideAttrs (oldAttrs: rec {
    version = "0.26";
    src = fetchgit {
      url = "https://github.com/python-xlib/python-xlib.git";
      rev = "${version}";
      sha256 = "0r036ggn02fz98014gs8jyyg9vyz2p8q4dyilkl3w4kdj6kc5alf";
    };
  });
in buildPythonPackage rec {
  pname = "ueberzug";

  version = "18.1.5";

  src = fetchgit {
    url = "https://github.com/seebye/ueberzug.git";
    rev = "${version}";
    sha256 = "1p3rfr6bs9ps05gv2cwvnl28gzxnslv6miv6sjxi7vxkyngv4y0l";
  };

  buildInputs = [ xorg.xlibsWrapper ];

  propagatedBuildInputs = [ xlib_23 psutil pillow attrs docopt ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/seebye/ueberzug";
    description =
      "Command line util which allows to draw images on terminals by using child windows.";
  };

}
