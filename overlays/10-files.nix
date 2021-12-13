final: prev: {
  flake-registry = prev.stdenv.mkDerivation rec {
    pname = "flake-registry";
    version = "git";
    src = prev.fetchFromGitHub {
      owner = "NixOS";
      repo = "flake-registry";
      rev = "142683660d8efac51d97b534a8bdedb5a9af1719";
      # date = 2021-12-10T15:42:29+01:00;
      sha256 = "17kc20iklday1s5rmmddgicasqhqs1n3z7939605fw0p5988zk49";
    };
    dontBuild = true;
    installPhase = ''
      cp flake-registry.json $out
    '';
  };
}
