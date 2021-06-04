final: prev: {
  flake-registry = prev.stdenv.mkDerivation rec {
    pname = "flake-registry";
    version = "git";
    src = prev.fetchFromGitHub {
      owner = "NixOS";
      repo = "flake-registry";
      rev = "846277a41f292c63d7c2a4bed07152d982829bcb";
      # date = 2021-03-01T11:53:21+01:00;
      sha256 = "0bmn66lwzh7cdhhw9bzbj0snmrgh431jd06aynkm5kdrrbwsq6qm";
    };
    dontBuild = true;
    installPhase = ''
      cp flake-registry.json $out
    '';
  };
}
