{ fetchFromGitHub
, buildPythonPackage
, mutagen
, marshmallow
, fuzzywuzzy
}:

buildPythonPackage {
  pname = "fuo_local";
  version = "0.2.1";
  src = fetchFromGitHub {
    owner = "feeluown";
    repo = "feeluown-local";
    rev = "36d8691304d8848da20a768713d5e6ce13437c87";
    # date = 2021-02-03T22:02:34+08:00;
    sha256 = "03xwg2731xmq7jja2hd5w3xlzxma05a7v2lc4p8r804jnmnmx5c3";
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
