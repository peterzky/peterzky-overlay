{ buildPythonPackage, i3ipc, fetchFromGitHub }:

buildPythonPackage rec {
  pname = "i3-quickterm";
  version = "git";

  src = fetchFromGitHub {
    owner = "peterzky";
    repo = "i3-quickterm";
    rev = "593855c2bef432b5d3b0a9bb6ba83f6307a49efc";
    # date = 2021-06-06T11:42:00+08:00;
    sha256 = "0zz3rcdpmg0x4snhky1c0ppbmjf2sjv7y80sq6kcjzb3i7jh0dk7";
  };

  doCheck = false;

  propagatedBuildInputs = [ i3ipc ];

}
