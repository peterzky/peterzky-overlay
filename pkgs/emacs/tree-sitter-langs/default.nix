{ lib
, symlinkJoin
, fetchzip
, melpaBuild
, stdenv
, fetchFromGitHub
, writeText
}:

let
  version = "0.10.12";

  meta = with lib; {
    description = "Language bundle for Emacs's tree-sitter package.";
    homepage = "https://github.com/emacs-tree-sitter/tree-sitter-langs";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ pimeys ];
  };

  tree-sitter-grammars = stdenv.mkDerivation rec {
    name = "tree-sitter-grammars";

    inherit version;
    inherit meta;

    src = fetchzip {
      name = "tree-sitter-grammars-linux-${version}.tar.gz";
      url = "https://github.com/emacs-tree-sitter/tree-sitter-langs/releases/download/${version}/${src.name}";
      sha256 = "sha256-r6ZplaSqLBhzSfQk1zc4fSj+xqphWcTPmEdmpUrmZAo=";
      stripRoot = false;
    };

    installPhase = ''
      install -d $out/langs/bin
      echo -n $version > $out/langs/bin/BUNDLE-VERSION
      install -m444 * $out/langs/bin
    '';
  };
in melpaBuild rec {
  inherit version;
  inherit meta;

  pname = "tree-sitter-langs";
  commit = version;

  src = fetchFromGitHub {
    owner = "emacs-tree-sitter";
    repo = "tree-sitter-langs";
    rev = version;
    sha256 = "072y9cmyn926w5vlf6flj83j3n87w6qy7jx9akrnbys0907c17s8";
  };

  recipe = writeText "recipe" ''
    (tree-sitter-langs
    :repo "emacs-tree-sitter/tree-sitter-langs"
    :fetcher github)
  '';

  postPatch = ''
    substituteInPlace ./tree-sitter-langs-build.el \
    --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir" \
    "tree-sitter-langs-grammar-dir \"${tree-sitter-grammars}/langs\""
  '';
}
