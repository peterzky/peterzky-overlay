{ lib
, symlinkJoin
, melpaBuild
, fetchFromGitHub
, rustPlatform
, writeText
, clang
, llvmPackages
}:
with lib.licenses;
with rustPlatform;
with llvmPackages;

let
  version = "0.16.0";

  meta = {
    description = "The core APIs of the Emacs binding for tree-sitter.";
    license = mit;
    maintainers = with maintainers; [ pimeys ];
  };

  src = fetchFromGitHub {
    owner = "emacs-tree-sitter";
    repo = "elisp-tree-sitter";
    rev = version;
    sha256 = "sha256-SNv0NBJ4vjrlH5TaiekRRT8Tfk9cfmZxRhZdf8Ye+58=";
  };

  tsc = melpaBuild rec {
    inherit src;
    inherit version;

    pname = "tsc";
    commit = version;

    sourceRoot = "source/core";

    recipe = writeText "recipe" ''
      (tsc
      :repo "emacs-tree-sitter/elisp-tree-sitter"
      :fetcher github)
    '';
  };

  tsc-dyn = buildRustPackage {
    inherit version;
    inherit src;

    pname = "tsc-dyn";
    commit = version;

    nativeBuildInputs = [ clang ];
    sourceRoot = "source/core";

    configurePhase = ''
      export LIBCLANG_PATH="${libclang.lib}/lib"
    '';

    postInstall = ''
      LIB=($out/lib/libtsc_dyn.*)
      TSC_PATH=$out/share/emacs/site-lisp/elpa/tsc-${version}
      install -d $TSC_PATH
      install -m444 $out/lib/libtsc_dyn.* $TSC_PATH/''${LIB/*libtsc_/tsc-}
      echo -n $version > $TSC_PATH/DYN-VERSION
      rm -r $out/lib
    '';

    cargoSha256 = "sha256-Kb0RKh0l3extAVPAheiWWZRE0qLwgM4BPtZT9zt8nk8=";
  };
in
symlinkJoin {
  name = "tsc";
  paths = [ tsc tsc-dyn ];
}
