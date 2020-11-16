{ buildPythonPackage, i3ipc }:

buildPythonPackage rec {
  pname = "i3-wk-switch";
  version = "git";

  src = ./.;

  propagatedBuildInputs = [ i3ipc ];

  dontBuild = true;
  doCheck = false;

  installPhase = ''
    mkdir -p "$out/bin"
    cp i3-wk-switch.py "$out/bin/i3-wk-switch"
  '';

}
