{ stdenv, lib, buildPythonPackage, fetchFromGitHub, enum-compat, xorgserver, i3
, python, xlib, xdpyinfo, makeFontsConf, coreutils }:

buildPythonPackage rec {
  pname = "i3ipc";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "acrisci";
    repo = "i3ipc-python";
    rev = "v${version}";
    sha256 = "13bzs9dcv27czpnnbgz7a037lm8h991c8gk0qzzk5mq5yak24715";
  };
  propagatedBuildInputs = [ enum-compat xlib ];

  fontsConf = makeFontsConf { fontDirectories = [ ]; };
  FONTCONFIG_FILE =
    fontsConf; # Fontconfig error: Cannot load default config file

  doCheck = false;

  meta = with lib; {
    description = "An improved Python library to control i3wm and sway";
    homepage = "https://github.com/acrisci/i3ipc-python";
    license = licenses.bsd3;
    maintainers = with maintainers; [ vanzef ];
  };
}
