final: prev:
let
  overrides = hsfinal: hsprev: {
    xmonad = prev.haskell.lib.overrideCabal hsprev.xmonad (_: rec {
      src = prev.fetchFromGitHub {
        owner = "xmonad";
        repo = "xmonad";
        rev = "33a86c0cdb9aa481e23cc5527a997adef5e32d42";
        # date = 2021-09-14T11:25:18+01:00;
        sha256 = "05531x3ixi0r52z86qsrg92cl7rwpgs98asspqb02nljjkbdrhpq";
      };
      version = "0.16.99999";
      patches = [ ];
      editedCabalFile = null;
    }
    );

    xmonad-contrib = prev.haskell.lib.overrideCabal hsprev.xmonad-contrib (_: rec {
      src = prev.fetchFromGitHub {
        owner = "xmonad";
        repo = "xmonad-contrib";
        rev = "fa3536b40bc121b6cc724ee393b14b7db44db890";
        # date = 2021-10-14T13:50:09-04:00;
        sha256 = "1fgyds0xbxirn0sx25cj7sivmp0a8pdkrzgdbq8dsj54pna6xm6l";
      };
      version = "0.16.999";
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
