{ fetchFromGitHub
, buildPythonPackage
, mutagen
, marshmallow
, fuzzywuzzy
, lib
}:

buildPythonPackage {
  pname = "fuo_local";
  version = "0.2.1";
  src = fetchFromGitHub {
    inherit (lib.importJSON ./local.json) owner repo rev sha256;
  };

  patchPhase = ''
    sed -i "/'feeluown'/d" setup.py
  '';

  propagatedBuildInputs = [
    mutagen
    marshmallow
    fuzzywuzzy
  ];

  doCheck = false;


}
