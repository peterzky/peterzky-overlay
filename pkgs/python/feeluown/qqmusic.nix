{ fetchFromGitHub
, buildPythonPackage
, marshmallow
, requests
, lib
}:

buildPythonPackage {
  pname = "fuo_qqmusic";
  version = "0.8";
  src = fetchFromGitHub {
    inherit (lib.importJSON ./qqmusic.json) owner repo rev sha256;
  };

  patchPhase = ''
    sed -i '/feeluown>/d' setup.py
  '';

  propagatedBuildInputs = [
    marshmallow
    requests
  ];

  doCheck = false;


}
