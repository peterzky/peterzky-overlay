{ fetchFromGitHub
, buildPythonPackage
, beautifulsoup4
, pycryptodome
, marshmallow
, requests
}:

buildPythonPackage {
  pname = "fuo_netease";
  version = "0.8";
  src = fetchFromGitHub {
    owner = "feeluown";
    repo = "feeluown-netease";
    rev = "df2b1ef7b78c9f153bf9c9a273ef1304222a7f1c";
    # date = 2021-11-06T12:50:55+08:00;
    sha256 = "0qqr1b1c428gad5c7vqk7y1i31jvi8gzln6xq0l81ml2mx8n8gzf";
  };

  patchPhase = ''
    sed -i '/feeluown>/d' setup.py
  '';

  propagatedBuildInputs = [
    beautifulsoup4
    pycryptodome
    marshmallow
    requests
  ];

  doCheck = false;


}
