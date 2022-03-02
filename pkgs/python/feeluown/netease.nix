{ fetchFromGitHub
, buildPythonPackage
, fetchPypi
, beautifulsoup4
, pycryptodome
, marshmallow
, requests
, mutagen
, lib
}:
buildPythonPackage {
  pname = "fuo_netease";
  version = "0.8";
  src = fetchFromGitHub {
    inherit (lib.importJSON ./netease.json) owner repo rev sha256;
  };

  patchPhase = ''
    sed -i '/feeluown>/d' setup.py
  '';

  propagatedBuildInputs = [
    beautifulsoup4
    pycryptodome
    marshmallow
    requests
    mutagen
  ];

  doCheck = false;


}
