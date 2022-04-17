{ buildPythonPackage, i3ipc, fetchFromGitHub, lib }:
buildPythonPackage rec {
  pname = "i3-quickterm";
  version = "git";
  src = fetchFromGitHub {
    owner = "peterzky";
    repo = "i3-quickterm";
    rev = "2a7d5eb5e74fe9ebe06e06175545d1bd91f81537";
    sha256 = "1jqdca6vc8l4wz78gk7zszan7a4zvry0766kmkba3r9w4c19q0sx";
  };
  propagatedBuildInputs = [ i3ipc ];

  doCheck = false;
}
