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
        rev = "5085e72217c5e17233ab3492bcd3d1c3a9c2e40e";
        # date = 2021-10-13T20:38:39+02:00;
        sha256 = "0jaq8ck7ksf2ycxg7ybqi4ra65d2qjk5nnnl6kwbw9c8b9mr7khd";
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
