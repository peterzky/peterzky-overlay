{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "lsix";
  version = "git";
  src = fetchFromGitHub {
    owner = "hackerb9";
    repo = "lsix";
    rev = "46b304207b3b44d53f0783ee54694cb42a88d8a2";
    # date = 2021-05-06T11:31:01-07:00;
    sha256 = "0w298w8xy30kg1hbj9szc28p910l9b3da1prx5hpbmffn7kqp6r0";
  };
  dontBuild = true;
  installPhase = ''
    install -Dm755 lsix $out/bin/lsix
  '';
}
