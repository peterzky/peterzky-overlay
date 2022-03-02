{ fetchFromGitHub
, buildPythonPackage
, fetchPypi
, janus
, requests
, tomlkit
, packaging
, pydantic
, qasync
, pyqt5
, mpv
, wrapQtAppsHook
, lib
, extensions ? [ ]
}:
buildPythonPackage {
  pname = "feeluown";
  version = "git";
  src = fetchFromGitHub {
    inherit (lib.importJSON ./base.json) owner repo rev sha256;
  };

  nativeBuildInputs = [
    wrapQtAppsHook
  ];

  propagatedBuildInputs = [
    pyqt5
    janus
    requests
    tomlkit
    packaging
    pydantic
    qasync
  ] ++ extensions;

  doCheck = false;

  postFixup = ''
    for f in $out/bin/fuo $out/bin/feeluown; do
      wrapQtApp "$f" --prefix MPV_DYLIB_PATH : "${mpv}/lib/libmpv.so"
    done;
  '';

}
