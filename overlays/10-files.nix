final: prev: {
  flake-registry = prev.stdenv.mkDerivation rec {
    pname = "flake-registry";
    version = "git";
    src = prev.fetchFromGitHub {
      inherit (prev.lib.importJSON ../meta/flake-registry.json) owner repo rev sha256;
    };
    dontBuild = true;
    installPhase = ''
      cp flake-registry.json $out
    '';
  };
}
