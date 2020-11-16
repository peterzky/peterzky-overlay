{ stdenv, python36 }:

stdenv.mkDerivation {
  name = "thinkpad_x1_rotation";

  buildInputs = [
    (python36.withPackages
    (pythonPackages: with pythonPackages; [ dbus-python docopt pygobject3 ]))
  ];

  unpackPhase = ":";
  installPhase = ''
    install -m755 -D ${./thinkpad.py} $out/bin/yoga
  '';
}
