final: prev:
let
  overrides = hsfinal: hsprev: {
    xmonad = prev.haskell.lib.overrideCabal hsprev.xmonad (_: rec {
      src = prev.fetchFromGitHub {
        inherit (prev.lib.importJSON ../meta/xmonad.json) owner repo rev sha256;
      };
      version = prev.lib.concatStrings
        [
          "0.16.99999"
          "-"
          (prev.lib.substring 0 5 src.rev)
        ];
      patches = [ ];
      editedCabalFile = null;
    }
    );

    xmonad-contrib = prev.haskell.lib.overrideCabal hsprev.xmonad-contrib (_: rec {
      src = prev.fetchFromGitHub {
        inherit (prev.lib.importJSON ../meta/xmonad-contrib.json) owner repo rev sha256;
      };
      version = prev.lib.concatStrings
        [
          "0.16.999"
          "-"
          (prev.lib.substring 0 5 src.rev)
        ];
      doCheck = false;
      editedCabalFile = null;
    }
    );

  };
in
{
  haskellPackages = prev.haskellPackages.override {
    inherit overrides;
  };
}
