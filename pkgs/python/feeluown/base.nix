{ fetchFromGitHub
, buildPythonPackage
, janus
, requests
, tomlkit
, packaging
, pydantic
, pyqt5
, mpv
, wrapQtAppsHook
, lib
, extensions ? [ ]
}:
let
  qasync = buildPythonPackage {
    pname = "qasync";
    version = "git";
    src = fetchFromGitHub {
      owner = "CabbageDevelopment";
      repo = "qasync";
      rev = "bae9d600615e06a32a7ea9e17aebf805e7d8ffe0";
      # date = 2021-09-15T23:01:26+01:00;
      sha256 = "1q9cllrwf94whr0f6mipa0hdq1rcyqvklwx19g35g2dav8f3xkjl";
    };
    doCheck = false;
  };
in
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
      wrapProgram "$f" \
        --prefix MPV_DYLIB_PATH : "${mpv}/lib/libmpv.so"
    done;
  '';

}
