{ fetchFromGitHub
, buildPythonPackage
, marshmallow
, requests
}:

buildPythonPackage {
  pname = "fuo_qqmusic";
  version = "0.8";
  src = fetchFromGitHub {
    owner = "feeluown";
    repo = "feeluown-qqmusic";
    rev = "07b8172fceede4c66bb91c4b28e5e73629d61bbe";
    # date = 2021-11-06T17:57:45+08:00;
    sha256 = "0cnl2cjir95imm3g8600dp4ja4c2fwgd6skf50jdvgw7i5997vbz";
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
