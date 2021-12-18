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
    owner = "feeluown";
    repo = "FeelUOwn";
    rev = "2418d511a3cdc3fdef179b23cfa8578915b30da3";
    # date = 2021-12-17T09:59:30+08:00;
    sha256 = "0imxhm2dxldqpmrrpjb6bjbjbqd45c4gmhv69d113b5k09qdj914";
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
